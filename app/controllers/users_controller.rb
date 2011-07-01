class UsersController < ApplicationController
  before_filter :authenticate, :except => :index
  
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
  
  def register
    @user = current_user
    @user.full_name ||= @user.name
    @user.status ||= 0
    if request.put?
      @user.update_attributes(params[:user])
      @user.save and redirect_to root_path, :notice => 'signed up'
    end
  end
end
