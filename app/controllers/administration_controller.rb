class AdministrationController < ApplicationController
  before_filter :onlyAdmin
  layout 'admin_base'
  def index
  end
    
end
