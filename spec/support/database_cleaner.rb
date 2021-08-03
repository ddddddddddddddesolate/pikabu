# frozen_string_literal: true

RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner[:active_record].clean_with :truncation, except: %w[ar_internal_metadata]
  end

  config.before :each do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner[:active_record].start
  end

  config.after :each do
    DatabaseCleaner[:active_record].clean
  end
end
