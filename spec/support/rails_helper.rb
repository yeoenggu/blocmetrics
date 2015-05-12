include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end
end