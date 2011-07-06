class UsersController < ApplicationController
  def index
    @users = {
      :all => User.all,
      :yes => User.yes,
      :maybe => User.maybe,
      :no => User.no
    }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
end
