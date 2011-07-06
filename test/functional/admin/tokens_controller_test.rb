require 'test_helper'

class Admin::TokensControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @token = tokens(:one)
    sign_in :user, @user
  end

  test "should get show" do
    get :show, :user_id => @user.to_param, :id => @token.to_param
    assert_response :success
  end

  test "should destroy token" do
    assert_difference('Token.count', -1) do
      delete :destroy, :user_id => @user.to_param, :id => @token.to_param
    end
    assert_redirected_to edit_admin_user_path(@user)
  end

end
