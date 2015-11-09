server 'mooc-lti-web-01.oit.duke.edu', :app, :web, :db, :primary => true
set :rails_env, 'production'
set :deploy_via, :export
set :vhost, 'mooc-lti.oit.duke.edu'

default_environment.delete :http_proxy
default_environment.delete :HTTPS_PROXY
