require "test_helper"

class InquiryCreateTest < ActionDispatch::IntegrationTest

#   test "should be present inquiry name" do
#     get new_inquiry_path
#     assert_template 'contacts/new'
#     post contacts_path, params: { inquiry: { name: "",
#                                              email:"test@example.com",
#                                              message: "test inqiry. tell me about"} }
#     assert_template 'contacts/new'
#   end

#   test "should be present inquiry email" do
#     get new_inquiry_path
#     assert_template 'contacts/new'
#     post contacts_path, params: { inquiry: { name: "test user",
#                                              email:"",
#                                              message: "test inqiry. tell me about"} }
#     assert_template 'contacts/new'
#   end

#   test "should be valid inquiry email format" do
#     get new_inquiry_path
#     assert_template 'contacts/new'
#     post contacts_path, params: { inquiry: { name: "test user",
#                                              email:"test@example..com",
#                                              message: "test inqiry. tell me about"} }
#     assert_template 'contacts/new'
#   end

#   test "should be present inquiry message" do
#     get new_inquiry_path
#     assert_template 'contacts/new'
#     post contacts_path, params: { inquiry: { name: "test user",
#                                              email:"test@example.com",
#                                              message: ""} }
#     assert_template 'contacts/new'
#   end

#   test "valid information and back" do
#     get new_inquiry_path
#     assert_template 'contacts/new'
#     post contacts_path, params: { inquiry: { name: "test user",
#                                              email:"test@example.com",
#                                              message: "test inqiry. tell me about"} }
#     assert_redirected_to 'contacts/done'
#     assert_template 'contacts/new'
#   end
end
