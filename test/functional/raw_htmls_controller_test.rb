require 'test_helper'

class RawHtmlsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_htmls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_html" do
    assert_difference('RawHtml.count') do
      post :create, :raw_html => { }
    end

    assert_redirected_to raw_html_path(assigns(:raw_html))
  end

  test "should show raw_html" do
    get :show, :id => raw_htmls(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => raw_htmls(:one).id
    assert_response :success
  end

  test "should update raw_html" do
    put :update, :id => raw_htmls(:one).id, :raw_html => { }
    assert_redirected_to raw_html_path(assigns(:raw_html))
  end

  test "should destroy raw_html" do
    assert_difference('RawHtml.count', -1) do
      delete :destroy, :id => raw_htmls(:one).id
    end

    assert_redirected_to raw_htmls_path
  end
end
