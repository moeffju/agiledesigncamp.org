class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    unless user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      user = User.create_with_omniauth(auth)
      user.status = 1
      user.save
    end
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Angemeldet!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Abgemeldet!"
  end
  
  def signin
  end
end
