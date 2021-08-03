# frozen_string_literal: true

require_relative "boot"

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Pikabu
  class Application < Rails::Application
    config.load_defaults 6.1
    config.api_only = true

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    config.autoload_paths << Rails.root.join("lib")

    config.logger = Logger.new($stdout)
  end
end
