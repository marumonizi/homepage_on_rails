require "test_helper"

class ContactCreateTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "should be present contact name" do
    get new_contact_path
    assert_template 'contacts/new'
    post contacts_path, params: { contact: { name: "",
                                             email:"test@example.com",
                                             message: "test inqiry. tell me about",
                                             category: "商品について"} }
    assert_template 'contacts/new'
  end

  test "should be present contact email" do
    get new_contact_path
    assert_template 'contacts/new'
    post contacts_path, params: { contact: { name: "test user",
                                             email:"",
                                             message: "test inqiry. tell me about",
                                             category: "商品について"} }
    assert_template 'contacts/new'
  end

  test "should be valid contact email format" do
    get new_contact_path
    assert_template 'contacts/new'
    assert_no_difference "Contact.count" do
      post contacts_path, params: { contact: { name: "test user",
                                               email:"test@example..com",
                                               message: "test inqiry. tell me about",
                                               category: "商品について"} }
    end
    assert_template 'contacts/new'
  end

  test "should be present contact message" do
    get new_contact_path
    assert_template 'contacts/new'
    post contacts_path, params: { contact: { name: "test user",
                                             email:"test@example.com",
                                             message: ""},
                                             category: "商品について"}
    assert_template 'contacts/new'
  end

  test "should be present contact category" do
    get new_contact_path
    assert_template 'contacts/new'
    post contacts_path, params: { contact: { name: "test user",
                                             email:"test@example.com",
                                             message: ""},
                                             category: ""}
    assert_template 'contacts/new'
  end

  test "valid contact information" do
    get new_contact_path
    assert_template 'contacts/new'
    post contacts_path, params: { contact: { name: "test user",
                                             email:"test@example.com",
                                             message: "test inqiry. tell me about",
                                             category: "商品について"} }
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to done_url
    follow_redirect!
    assert_template 'contacts/done'
  end
end
