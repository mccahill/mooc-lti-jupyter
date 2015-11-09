class LtiController < ApplicationController
  require 'rest_client'
  require 'oauth/request_proxy/rack_request'
  
  layout 'minimalist'
      
  skip_before_filter :authorize   #TODO: overwrite it is probably the best thing  

  # GET /learning_tools
  def jupyter
    
    #{"oauth_consumer_key"=>"test", "oauth_signature_method"=>"HMAC-SHA1", "oauth_timestamp"=>"1443817991", "oauth_nonce"=>"wvhvA76bmeS6ckrNbGNr9fobCsxtgMNwAFGvsVII", "oauth_version"=>"1.0", "context_id"=>"bestcourseever", "context_title"=>"Example Sinatra Tool Consumer", "custom_message_from_sinatra"=>"hey from the sinatra example consumer", "launch_presentation_return_url"=>"http://127.0.0.1:9393/tool_return", "lis_outcome_service_url"=>"http://127.0.0.1:9393/grade_passback", "lis_person_name_given"=>"test2", "lis_result_sourcedid"=>"oi", "lti_message_type"=>"basic-lti-launch-request", "lti_version"=>"LTI-1.0", "resource_link_id"=>"thisisuniquetome", "roles"=>"Learner", "tool_consumer_instance_name"=>"Frankie", "user_id"=>"ad0234829205b9033196ba818f7a872b", "oauth_signature"=>"j2XndrELqZXjJ9/kXMqRzY4fno4="}
    
    # the consumer keys/secrets
    $oauth_creds = {"test" => "secret", APP_CREDS["consumer_key"] => APP_CREDS["secret"]}
    
    if key = params['oauth_consumer_key']
      if secret = $oauth_creds[key]
        @tp = IMS::LTI::ToolProvider.new(key, secret, params)
      else
        @tp = IMS::LTI::ToolProvider.new(nil, nil, params)
        @tp.lti_msg = "Your consumer didn't use a recognized key."
        @tp.lti_errorlog = "You are doing it wrong!"
        show_error "Consumer key wasn't recognized"
        return false
      end
    else
      show_error "No consumer key"
      return false
    end
    
    @lti_session = LtiUserSession.new
    @lti_session.username = @tp.username("Dude")
    @lti_session.userId = @tp.user_id 
    @lti_session.userEmail = @tp.lis_person_contact_email_primary 
    @lti_session.destination = params['custom_notebook']   
    @lti_session.save!
    
    if !@tp.valid_request?(request)
      show_error "The OAuth signature was invalid"
      return false
    end

    if Time.now.utc.to_i - @tp.request_oauth_timestamp.to_i > 60*60
      show_error "Your request is too old."
      return false
    end

    if was_nonce_used_in_last_x_minutes?(@tp.request_oauth_nonce, @tp.user_id, 60)
      show_error "LTI error: nonce was reused"
      return false
    end
        
    self.passthrough_to_tool
  end
  
  def show_error(message)
    LtiUserSession.log(@lti_session.userId, @lti_session.username, @lti_session.userEmail, 'LTI Error'," #{message}" )                
    @message = message
    logger.error @message
  end
  
  def was_nonce_used_in_last_x_minutes?( nonce, userId, minutes )
    # make sure it has not been used already and store the nonce in the database 
    # at some point we should also clear old nonces from the db
    #found_nonce = LtiNonce.find_by_nonce( nonce )
    
    found_nonce = LtiNonce.find_by_sql ["SELECT * FROM lti_nonces WHERE nonce = ? and TIMESTAMPDIFF(MINUTE, updated_at, UTC_TIMESTAMP()) < ?", nonce, minutes]
    if found_nonce.length == 0 
      @lti_nonce = LtiNonce.new
      @lti_nonce.nonce = nonce
      @lti_nonce.userId = userId
      @lti_nonce.save!
      return false
    else
      # yes, this nonce has been presented to us in the last x minutes
      return true
    end
  end
  
  def renew
    # placeholder in case we decide to allow them to renew containers
  end
 
  def passthrough_to_tool
    # render 'containers/jupyter_from_lti_debug'
    
    #container_type = request.path.split("/").last
    container_type = 'jupyter'
    if container_type == 'renew' then
      self.renew
    else
      @first_visit = true
      reserved_instance = LtiDocker.find(:first, :conditions=> ["userId = ? and lower(appname) = ?", @lti_session.userId, container_type])
      if reserved_instance.nil? then # they have never reserved an instance
        new_instance = LtiDocker.find_by_userId_and_appname('', container_type)
        if new_instance.nil? then 
            logger.error "Failed to reserve Docker #{container_type} instance for user: #{@lti_session.userId}"
            LtiUserSession.log(@lti_session.userId, @lti_session.username, @lti_session.userEmail, 'Error',"Failed to reserve Docker #{container_type} instance for user: #{@lti_session.userId}", @lti_session.destination )            
            flash[:error] = "ERROR: Cannot find an unused Docker container for #{container_type}"
            redirect_to "/containers" and return
        else  # reserve this instance
          new_instance.userId = @lti_session.userId
          new_instance.username = @lti_session.username         
          new_instance.userEmail = @lti_session.userEmail
          new_instance.save!
                    
          @docker_host = new_instance.host
          @docker_port = new_instance.port
          @docker_guest_pw = new_instance.pw  
          LtiUserSession.log(@lti_session.userId, @lti_session.username, @lti_session.userEmail, 'LtiDocker containers',"Docker: #{@lti_session.userId} reserved #{container_type} at #{@docker_host}:#{@docker_port}", @lti_session.destination )                
        end
      else #send them to the instance they previously reserved
        @first_visit = false
        @docker_host = reserved_instance.host
        @docker_port = reserved_instance.port
        @docker_guest_pw = reserved_instance.pw    
      end 
      if container_type == 'jupyter'
        # jupyter/iPython notebook-specific code here 
      end
      LtiUserSession.log(@lti_session.userId, @lti_session.username, @lti_session.userEmail, 'LtiDocker containers',"Docker: #{@lti_session.userId} logging into #{container_type} at #{@docker_host}:#{@docker_port}", @lti_session.destination )    
    end
    if @lti_session.destination.nil?
      @optional_after_login_clause = ''
    else
      @optional_after_login_clause = "?next=/#{@lti_session.destination}"
    end
    render :template => "lti/#{container_type.downcase}" 
  end
  
  
  
  

end
