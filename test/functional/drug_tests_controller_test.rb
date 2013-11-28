require 'test_helper'

class DrugTestsControllerTest < ActionController::TestCase
  setup do
    @drug_test = drug_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drug_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create drug_test" do
    assert_difference('DrugTest.count') do
      post :create, drug_test: {  }
    end

    assert_redirected_to drug_test_path(assigns(:drug_test))
  end

  test "should show drug_test" do
    get :show, id: @drug_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @drug_test
    assert_response :success
  end

  test "should update drug_test" do
    put :update, id: @drug_test, drug_test: {  }
    assert_redirected_to drug_test_path(assigns(:drug_test))
  end

  test "should destroy drug_test" do
    assert_difference('DrugTest.count', -1) do
      delete :destroy, id: @drug_test
    end

    assert_redirected_to drug_tests_path
  end
end
