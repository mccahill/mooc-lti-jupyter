# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mooc_lti::Application.initialize!
APP_CONFIG = YAML.load_file("#{Rails.root}/config/mooc-lti-creds.yml")[Rails.env]
APP_CREDS = YAML.load_file("#{Rails.root}/config/mooc-lti-creds.yml")[Rails.env]

# I hate how the error messages are rendered
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /^<label/
    "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe  
  else
    html_tag.html_safe
  end
end

