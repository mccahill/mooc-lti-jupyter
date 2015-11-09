class LtiDocker < ActiveRecord::Base
  attr_accessible :appdesc, :appname, :expired, :host, :port, :pw, :userEmail, :userId, :username
end
