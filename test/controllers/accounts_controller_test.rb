require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get accounts_create_url
    assert_response :success
  end

  test "should get show" do
    get accounts_show_url
    assert_response :success
  end

end
