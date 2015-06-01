require 'rails_helper'
#ActiveRecord::Base.logger = Logger.new(STDOUT)
RSpec.configure do |config|
  Capybara.javascript_driver = :webkit
  Capybara.default_wait_time = 5
  config.include AcceptanceHelper, type: :feature
  config.use_transactional_fixtures = false

  config.before(:suite) { DatabaseCleaner.clean_with :truncation }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
end