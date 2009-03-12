require 'test_helper'

class ArticleListItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_list_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_list_item" do
    assert_difference('ArticleListItem.count') do
      post :create, :article_list_item => { }
    end

    assert_redirected_to article_list_item_path(assigns(:article_list_item))
  end

  test "should show article_list_item" do
    get :show, :id => article_list_items(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => article_list_items(:one).id
    assert_response :success
  end

  test "should update article_list_item" do
    put :update, :id => article_list_items(:one).id, :article_list_item => { }
    assert_redirected_to article_list_item_path(assigns(:article_list_item))
  end

  test "should destroy article_list_item" do
    assert_difference('ArticleListItem.count', -1) do
      delete :destroy, :id => article_list_items(:one).id
    end

    assert_redirected_to article_list_items_path
  end
end
