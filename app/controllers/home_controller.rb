# coding: utf-8
class HomeController < ApplicationController
  def index
    @users = {
      :yes => User.yes,
      :maybe => User.maybe
    }
  end

  def rsvp
    unless current_user
      redirect_to '/signin', :alert => 'Bitte melde dich erst an!'
      return
    end
    current_user.comment = params[:user][:comment]
    if params[:yes]
      current_user.status = 1
      flash[:success] = 'Du bist dabei!'
    elsif params[:no]
      current_user.status = 0
      flash[:notice] = 'Wir werden Dich vermissen. :('
    elsif params[:maybe]
      current_user.status = 2
      flash[:notice] = 'Bitte gib uns schnellstmöglich Bescheid, damit wir planen können!'
    else
      redirect_to '/' and return
    end
    current_user.save
    redirect_to '/'
  end
  
  def impressum; end
  def sponsoring; end
  def credits; end
end
