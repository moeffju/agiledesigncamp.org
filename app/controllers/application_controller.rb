class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :is_admin?
  
  before_filter :redirect_domains
  
  def ensure_admin
    raise ActionController::RoutingError.new('Not Found') unless is_admin?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def is_admin?
    current_user && %w(5618832 14583478).include?(current_user.uid)
  end
  
  def redirect_domains
    if Rails.env.production?
      unless request.host == 'agiledesigncamp.org'
        redirect_to "http://agiledesigncamp.org" and return false
      end
    end
  end
  
end
