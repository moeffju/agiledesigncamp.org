class Admin::TokensController < ApplicationController
  def show
    @token = Token.find_by_id_and_user_id(params[:id], params[:user_id])
  end

  def destroy
    @token = Token.find_by_id_and_user_id(params[:id], params[:user_id])
    if @token
      @token.destroy
      flash[:notice] = 'token destroyed'
    else
      flash[:error] = 'invalid token'
    end
    redirect_to edit_admin_user_path(params[:user_id])
  end

end
