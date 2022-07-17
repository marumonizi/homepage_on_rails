require "test_helper"

class ContactUpdateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
    @contact = contacts(:first_contact)
    ActionMailer::Base.deliveries.clear
  end

  test "should be presence reply" do
    log_in_as(@user)
    get contact_path(@contact)
    assert_template 'contacts/show'
    assert_no_difference "Contact.count" do
      patch contact_path(@contact), params: { contact: { reply: "" } }
    end
    assert_template 'contacts/show'
  end
  
  test "valid reply" do
    log_in_as(@user)
    get contact_path(@contact)
    assert_template 'contacts/show'
    patch contact_path(@contact), params: { contact: { reply: "test reply" } }
    assert_redirected_to contacts_path
    follow_redirect!
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_template 'contacts/index'
    assert_select 'div.notice', 'test user様 に返信しました'
    @contact.reload
    assert_equal "test reply", @contact.reply
    assert_equal true, @contact.replyed
  end
end
