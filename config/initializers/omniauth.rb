Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
  provider :facebook, ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET'], :scope => ''
end
