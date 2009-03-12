require 'test_helper'

class PageSectionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_section" do
    assert_difference('PageSection.count') do
      post :create, :page_section => { }
    end

    assert_redirected_to page_section_path(assigns(:page_section))
  end

  test "should show page_section" do
    get :show, :id => page_sections(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => page_sections(:one).id
    assert_response :success
  end

  test "should update page_section" do
    put :update, :id => page_sections(:one).id, :page_section => { }
    assert_redirected_to page_section_path(assigns(:page_section))
  end

  test "should destroy page_section" do
    assert_difference('PageSection.count', -1) do
      delete :destroy, :id => page_sections(:one).id
    end

    assert_redirected_to page_sections_path
  end
end
