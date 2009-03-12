require 'test_helper'

class FileListItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:file_list_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create file_list_item" do
    assert_difference('FileListItem.count') do
      post :create, :file_list_item => { }
    end

    assert_redirected_to file_list_item_path(assigns(:file_list_item))
  end

  test "should show file_list_item" do
    get :show, :id => file_list_items(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => file_list_items(:one).id
    assert_response :success
  end

  test "should update file_list_item" do
    put :update, :id => file_list_items(:one).id, :file_list_item => { }
    assert_redirected_to file_list_item_path(assigns(:file_list_item))
  end

  test "should destroy file_list_item" do
    assert_difference('FileListItem.count', -1) do
      delete :destroy, :id => file_list_items(:one).id
    end

    assert_redirected_to file_list_items_path
  end
end
