Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'g7Gl5khqmMngmIG9wfwmPg', 'S53fYPaTlzc5QQz44dXiPbmOWUnyuEVjgdbr49oj0'
  provider :facebook, '209358412420026', '002cfef0d935fb0b9f7ff29de3db7a62', :scope => ''
end
