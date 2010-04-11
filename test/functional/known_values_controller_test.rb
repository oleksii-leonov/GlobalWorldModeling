require 'test_helper'

class KnownValuesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:known_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create known_value" do
    assert_difference('KnownValue.count') do
      post :create, :known_value => { }
    end

    assert_redirected_to known_value_path(assigns(:known_value))
  end

  test "should show known_value" do
    get :show, :id => known_values(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => known_values(:one).to_param
    assert_response :success
  end

  test "should update known_value" do
    put :update, :id => known_values(:one).to_param, :known_value => { }
    assert_redirected_to known_value_path(assigns(:known_value))
  end

  test "should destroy known_value" do
    assert_difference('KnownValue.count', -1) do
      delete :destroy, :id => known_values(:one).to_param
    end

    assert_redirected_to known_values_path
  end
end
