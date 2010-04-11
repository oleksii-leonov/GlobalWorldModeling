require 'test_helper'

class ModelVariableValuesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:model_variable_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create model_variable_value" do
    assert_difference('ModelVariableValue.count') do
      post :create, :model_variable_value => { }
    end

    assert_redirected_to model_variable_value_path(assigns(:model_variable_value))
  end

  test "should show model_variable_value" do
    get :show, :id => model_variable_values(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => model_variable_values(:one).to_param
    assert_response :success
  end

  test "should update model_variable_value" do
    put :update, :id => model_variable_values(:one).to_param, :model_variable_value => { }
    assert_redirected_to model_variable_value_path(assigns(:model_variable_value))
  end

  test "should destroy model_variable_value" do
    assert_difference('ModelVariableValue.count', -1) do
      delete :destroy, :id => model_variable_values(:one).to_param
    end

    assert_redirected_to model_variable_values_path
  end
end
