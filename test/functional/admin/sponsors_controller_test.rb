require 'test_helper'

class Admin::SponsorsControllerTest < ActionController::TestCase
  setup do
    @sponsor = sponsors(:one)
    @user = users(:one)
    sign_in :user, @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sponsor" do
    assert_difference('Sponsor.count') do
      post :create, :sponsor => @sponsor.attributes
    end

    assert_redirected_to admin_sponsors_path
  end

  test "should show sponsor" do
    get :show, :id => @sponsor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sponsor.to_param
    assert_response :success
  end

  test "should update sponsor" do
    put :update, :id => @sponsor.to_param, :sponsor => @sponsor.attributes
    assert_redirected_to admin_sponsors_path
  end

  test "should destroy sponsor" do
    assert_difference('Sponsor.count', -1) do
      delete :destroy, :id => @sponsor.to_param
    end

    assert_redirected_to admin_sponsors_path
  end
end
