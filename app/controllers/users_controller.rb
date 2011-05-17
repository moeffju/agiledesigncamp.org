class UsersController < ApplicationController
  before_filter :ensure_admin
  
  def index
    @users = {
      :yes => User.yes,
      :maybe => User.maybe,
      :no => User.no
    }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def check
    @user = User.find(params[:id])
    @user.arrived = true

    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_url, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
