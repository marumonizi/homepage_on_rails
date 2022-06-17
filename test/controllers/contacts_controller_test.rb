require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get new_contact_path
    assert_template 'contacts/new'
  end

  test "should get done" do
    get done_path
    assert_template 'contacts/done'
  end
end
