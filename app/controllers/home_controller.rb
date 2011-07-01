# coding: utf-8
class HomeController < ApplicationController
  def index
    @users = {
      :yes => User.yes,
      :maybe => User.maybe
    }
    @sponsors = Sponsor.all
  end

  def impressum; end
  def sponsoring; end
  def credits; end
  def about; end
  
  def admin
    ensure_admin
  end
end
