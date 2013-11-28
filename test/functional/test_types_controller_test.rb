require 'test_helper'

class TestTypesControllerTest < ActionController::TestCase
  setup do
    @test_type = test_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_type" do
    assert_difference('TestType.count') do
      post :create, test_type: {  }
    end

    assert_redirected_to test_type_path(assigns(:test_type))
  end

  test "should show test_type" do
    get :show, id: @test_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_type
    assert_response :success
  end

  test "should update test_type" do
    put :update, id: @test_type, test_type: {  }
    assert_redirected_to test_type_path(assigns(:test_type))
  end

  test "should destroy test_type" do
    assert_difference('TestType.count', -1) do
      delete :destroy, id: @test_type
    end

    assert_redirected_to test_types_path
  end
end
