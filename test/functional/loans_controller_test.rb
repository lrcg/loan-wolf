require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  test "should get newTo" do
    get :newTo
    assert_response :success
  end

  test "should get newFrom" do
    get :newFrom
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get listAll" do
    get :listAll
    assert_response :success
  end

end
