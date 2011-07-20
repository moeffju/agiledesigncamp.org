class UsersController < ApplicationController
  def index
    @users = {
      :all => User.all,
      :yes => User.yes,
      :waiting_list => User.waiting_list,
      :maybe => User.maybe,
      :no => User.no
    }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
end
