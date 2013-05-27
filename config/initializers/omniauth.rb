require 'omniauth-openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :browser_id, name: 'persona'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :open_id, name: 'google', store: OpenID::Store::Filesystem.new('./tmp'), identifier: 'https://www.google.com/accounts/o8/id'
end

OmniAuth.config.on_failure = SocialprovidersController.action(:oauth_failure)
