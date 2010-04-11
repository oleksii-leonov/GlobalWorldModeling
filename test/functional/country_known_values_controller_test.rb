require 'test_helper'

class CountryKnownValuesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:country_known_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create country_known_value" do
    assert_difference('CountryKnownValue.count') do
      post :create, :country_known_value => { }
    end

    assert_redirected_to country_known_value_path(assigns(:country_known_value))
  end

  test "should show country_known_value" do
    get :show, :id => country_known_values(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => country_known_values(:one).to_param
    assert_response :success
  end

  test "should update country_known_value" do
    put :update, :id => country_known_values(:one).to_param, :country_known_value => { }
    assert_redirected_to country_known_value_path(assigns(:country_known_value))
  end

  test "should destroy country_known_value" do
    assert_difference('CountryKnownValue.count', -1) do
      delete :destroy, :id => country_known_values(:one).to_param
    end

    assert_redirected_to country_known_values_path
  end
end
