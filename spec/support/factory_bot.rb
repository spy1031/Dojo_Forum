RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end