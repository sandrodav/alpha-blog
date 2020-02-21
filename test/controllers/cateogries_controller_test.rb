require 'test_helper'

class CategoriesControlelerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "lida", email: "lida@example.com", password: "password", admin: true)
  end

  test "Shoud get categories index" do
    get categories_path
    assert_response :success
  end

  test "Shoud get new" do
    sign_in_as(@user,"password")
    get new_category_path
    assert_response :success
  end

  test "shoud get show" do
    get category_path(@category)
    assert_response :success
  end

  test "should redirect create when amin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params:{category:{name:"sport"}}
    end
    assert_redirected_to categories_path
  end
end
