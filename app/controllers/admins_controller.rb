class AdminsController < ApplicationController
  layout 'admin_base'
  before_filter :onlyAdmin
  
  active_scaffold :"admin" do |conf|
    conf.label = 'MOOC LTI applications admins'
    active_scaffold_config.search.live = true   #submit search terms as we type for more feedback
    conf.list.sorting = { :id => :asc}
  end
 
end
