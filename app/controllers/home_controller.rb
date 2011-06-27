# coding: utf-8
class HomeController < ApplicationController
  def index
    @users = {
      :yes => User.yes,
      :maybe => User.maybe
    }
    @sponsors = Sponsor.all
  end

  def rsvp
    unless current_user
      session[:rsvp_saved_params] = params
      redirect_to '/signin', :alert => 'please sign in first!'
      return
    end
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
    else
      redirect_to '/' and return
    end
    current_user.save
    redirect_to '/'
  end
  
  def impressum; end
  def sponsoring; end
  def credits; end
  
  def admin
    ensure_admin
  end
end
