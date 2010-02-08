require 'test_helper'

class ThirdpartypeopleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thirdpartypeople)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thirdpartyperson" do
    assert_difference('Thirdpartyperson.count') do
      post :create, :thirdpartyperson => { }
    end

    assert_redirected_to thirdpartyperson_path(assigns(:thirdpartyperson))
  end

  test "should show thirdpartyperson" do
    get :show, :id => thirdpartypeople(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => thirdpartypeople(:one).to_param
    assert_response :success
  end

  test "should update thirdpartyperson" do
    put :update, :id => thirdpartypeople(:one).to_param, :thirdpartyperson => { }
    assert_redirected_to thirdpartyperson_path(assigns(:thirdpartyperson))
  end

  test "should destroy thirdpartyperson" do
    assert_difference('Thirdpartyperson.count', -1) do
      delete :destroy, :id => thirdpartypeople(:one).to_param
    end

    assert_redirected_to thirdpartypeople_path
  end
end
