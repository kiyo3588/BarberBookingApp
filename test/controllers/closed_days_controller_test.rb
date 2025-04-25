require "test_helper"

class ClosedDaysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get closed_days_index_url
    assert_response :success
  end

  test "should get new" do
    get closed_days_new_url
    assert_response :success
  end

  test "should get create" do
    get closed_days_create_url
    assert_response :success
  end

  test "should get edit" do
    get closed_days_edit_url
    assert_response :success
  end

  test "should get update" do
    get closed_days_update_url
    assert_response :success
  end

  test "should get destroy" do
    get closed_days_destroy_url
    assert_response :success
  end
end
