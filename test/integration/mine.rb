require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:rekha)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert edit_user_url(@user)
    patch user_path(@user), user: { name: "rekha", email: "rekha@example.com", password: "", password_confirmation: "" } 
    assert_not flash.empty?
    assert_redirected_to login_url
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end