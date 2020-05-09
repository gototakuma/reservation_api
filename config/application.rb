require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"


Bundler.require(*Rails.groups)

module ReservationApi
  class Application < Rails::Application

    config.load_defaults 6.0

    config.api_only = true

    config.action_dispatch.default_headers = {
      'Access-Control-Allow-Credentials' => 'true',
      'Access-Control-Allow-Origin' => 'https://reservation-vue.herokuapp.com',
      'Access-Control-Request-Method' => '*'
    }

    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
  end
end
