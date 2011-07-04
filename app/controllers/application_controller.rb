class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :is_admin?
  
  before_filter :redirect_domains, :check_profile
  
  def ensure_admin
    #raise ActionController::RoutingError.new('Not Found') unless is_admin?
  end
  
  def authenticate
    unless current_user
      session[:returnto] = request.fullpath
      redirect_to new_user_session_path and return
    end
  end
  
  def check_profile
    if request.get? && request.fullpath != edit_user_registration_path && current_user
      if (current_user.email && current_user.email.empty?) || current_user.tshirt_size.empty? || current_user.full_name.empty?
        redirect_to edit_user_registration_path, :notice => 'please complete your profile' and return
      end
    end
  end
  
  private

#  def current_user
#    @current_user ||= User.find(session[:user_id]) if session[:user_id]
#  end
  
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
