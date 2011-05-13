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
    case params[:commit]
    when /yes|ja/i
      current_user.status = 1
      flash[:success] = 'Du bist dabei!'
    when /no|nein/i
      current_user.status = 0
      flash[:notice] = 'Wir werden Dich vermissen. :('
    when /maybe|vielleicht/i
      current_user.status = 2
      flash[:notice] = 'Bitte gib uns schnellstmöglich Bescheid, damit wir planen können!'
    end
    current_user.save
    redirect_to '/'
  end

end
