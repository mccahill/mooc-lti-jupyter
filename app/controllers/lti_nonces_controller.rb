class LtiNoncesController < ApplicationController
  layout 'admin_base'
  before_filter :onlyAdmin
  
  active_scaffold :"lti_nonce" do |conf|
    conf.label = 'LTI users nonces'
    conf.actions = [:list, :search, :show]
    active_scaffold_config.search.live = true   #submit search terms as we type for more feedback
    conf.list.sorting = { :updated_at => :desc}
    conf.columns = [ :id, :userId, :nonce, :updated_at, :created_at ]
  end
end
