require 'test_helper'

class ContactListItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_list_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_list_item" do
    assert_difference('ContactListItem.count') do
      post :create, :contact_list_item => { }
    end

    assert_redirected_to contact_list_item_path(assigns(:contact_list_item))
  end

  test "should show contact_list_item" do
    get :show, :id => contact_list_items(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => contact_list_items(:one).id
    assert_response :success
  end

  test "should update contact_list_item" do
    put :update, :id => contact_list_items(:one).id, :contact_list_item => { }
    assert_redirected_to contact_list_item_path(assigns(:contact_list_item))
  end

  test "should destroy contact_list_item" do
    assert_difference('ContactListItem.count', -1) do
      delete :destroy, :id => contact_list_items(:one).id
    end

    assert_redirected_to contact_list_items_path
  end
end
