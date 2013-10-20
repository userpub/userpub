require 'auth_setup'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :jwt, setup: AuthSetup, uid_key: 'id'
  provider :persona
end