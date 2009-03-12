require 'test_helper'

class BiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bio" do
    assert_difference('Bio.count') do
      post :create, :bio => { }
    end

    assert_redirected_to bio_path(assigns(:bio))
  end

  test "should show bio" do
    get :show, :id => bios(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bios(:one).id
    assert_response :success
  end

  test "should update bio" do
    put :update, :id => bios(:one).id, :bio => { }
    assert_redirected_to bio_path(assigns(:bio))
  end

  test "should destroy bio" do
    assert_difference('Bio.count', -1) do
      delete :destroy, :id => bios(:one).id
    end

    assert_redirected_to bios_path
  end
end
