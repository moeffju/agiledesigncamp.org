class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :is_admin?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def is_admin?
    %w(5618832).include? current_user.uid
  end
end
