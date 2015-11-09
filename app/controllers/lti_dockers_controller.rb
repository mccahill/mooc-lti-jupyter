class LtiDockersController < ApplicationController
  layout 'admin_base'
  before_filter :onlyAdmin
  
  active_scaffold :"lti_docker" do |conf|
    conf.label = 'Docker Containers for MOOC LTI users'
    conf.actions = [:list, :search, :show]
    active_scaffold_config.search.live = true   #submit search terms as we type for more feedback
    conf.list.sorting = { :port => :asc}
    conf.columns = [ :id, :host, :port, :userEmail, :username,  :userId, :pw, :appname, :updated_at, :created_at ]
    conf.columns[:username].label = "name"
    conf.columns[:userEmail].label = "e-mail"
    conf.columns[:port].options[:format] = "%05d"
  end
    
end
