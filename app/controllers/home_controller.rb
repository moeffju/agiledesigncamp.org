# coding: utf-8
class HomeController < ApplicationController
  def index
    @users = {
      :yes => User.yes,
      :waiting_list => User.waiting_list,
      :maybe => User.maybe
    }
    @sponsors = Sponsor.all
  end

  def impressum; end
  def sponsoring; end
  def credits; end
  def about; end
  def timetable; end

  def sponsors
    @sponsors = Sponsor.all
  end
  
  def humanstxt
    @humans = <<-_EOF_.split(/\n/).map(&:strip)
    wolfgang wopperer
    liron tocker
    friederike schmiedebach
    sven kräuter
    jan krutisch
    katrin kampfrath
    björn jensen
    fabian fabian
    matthias bauer
    _EOF_
  end
  
  def admin
    ensure_admin
  end
end
