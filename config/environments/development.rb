# frozen_string_literal: true

require "active_support/core_ext/integer/time"

MAILER_CREDENTIALS = Rails.application.credentials.mailer

Rails.application.configure do
  config.hosts << "www.example.com"
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: MAILER_CREDENTIALS[:address],
    port: MAILER_CREDENTIALS[:port],
    authentication: MAILER_CREDENTIALS[:authentication],
    user_name: MAILER_CREDENTIALS[:user_name],
    password: MAILER_CREDENTIALS[:password]
  }

  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
