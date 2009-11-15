# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Specify gems that this application depends on and have them installed with rake gems:install
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem 'less', :source => 'http://gemcutter.org'
  config.gem 'binarylogic-authlogic', :lib => 'authlogic', :source => 'http://gems.github.com'

  # Skip frameworks you're not going to use.
  config.frameworks -= [ :active_resource ]
end

# Site-wide variables
FEEDBACK_EMAIL = 'feedback@listode.com'