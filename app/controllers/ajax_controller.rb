require 'ldap_tool'
class AjaxController < ApplicationController
  def users
    list = {}
    foo = []
    if params[:term]
      list = LdapTool.userLookup(params[:term])   
      list.each_pair do |netid, name|
        row = {}
        row['label'] = name
        row['value'] = netid
        foo << name
      end
    end
    render json: foo
  end
end
