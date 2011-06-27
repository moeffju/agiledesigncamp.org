class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    unless user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      user = User.create_with_omniauth(auth)
      user.status = 1
      user.save
    end
    session[:user_id] = user.id
    if params = session[:rsvp_saved_params]
      current_user.comment = params[:user][:comment]
      current_user.signup_at = Time.now
      if params[:yes]
        current_user.status = 1
        flash[:success] = 'you\'re in!'
      elsif params[:no]
        current_user.status = 0
        flash[:notice] = 'we will miss you :('
      elsif params[:maybe]
        current_user.status = 2
        flash[:notice] = 'please let us know whether you can make it asap'
      end
    end
    redirect_to root_url, :notice => "signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "signed out!"
  end
  
  def signin
  end
end
