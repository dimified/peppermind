require 'omniauth-openid'
require 'openid/store/filesystem'

API_KEYS = YAML::load_file(File.join(Rails.root, 'config', 'api_keys.yml'))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :browser_id, name: 'persona'
  provider :facebook, API_KEYS['facebook']['key'], API_KEYS['facebook']['secret']
  provider :twitter, API_KEYS['twitter']['key'], API_KEYS['twitter']['secret']
  provider :open_id, name: 'google', store: OpenID::Store::Filesystem.new('./tmp'), identifier: 'https://www.google.com/accounts/o8/id'
end
