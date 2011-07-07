class Admin::UsersController < ApplicationController
  before_filter :ensure_admin
  
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
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save
      redirect_to admin_users_path, :notice => 'User data changed'
    else
      redirect_to edit_admin_user_path(@user), :error => 'Errors saving user'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def check_in
    @user = User.find(params[:id])
    User.record_timestamps = false
    @user.status = 1
    @user.arrived = true
    @user.arrived_at = Time.now
    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_url, :notice => 'User checked in!') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
    User.record_timestamps = true
  end

  def check_out
    @user = User.find(params[:id])
    User.record_timestamps = false
    @user.arrived = false
    @user.arrived_at = Time.now
    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_url, :notice => 'User checked out!') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
    User.record_timestamps = true
  end

end
