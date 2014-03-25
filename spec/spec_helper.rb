ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'

SimpleCov.start do 
  add_filter "/config/"
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
end

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.mock_with :mocha

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.use_transactional_fixtures = true
  config.order = "random"

end
