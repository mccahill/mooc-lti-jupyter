server 'mooc-lti-test-web-01.oit.duke.edu', :app, :web, :db, :primary => true

set :rails_env, 'test'
set :deploy_via, :export

# This is a duke-specific set
set :vhost, 'mooc-lti-test.oit.duke.edu'

set :branch, 'staging'

