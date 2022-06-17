require "test_helper"

class ContactTest < ActiveSupport::TestCase

  def setup
    @contact = Contact.new(name:"test user", email:"test@example.com", message:"test contact message", category:"商品について")
  end

  test "should presence contact name" do
    @contact.name = ""
    assert_not @contact.valid?
  end

  test "should presence contact email" do
    @contact.email = ""
    assert_not @contact.valid?
  end

  test "shoud not accept invalid email format" do
    invalid_addresses = %w[test,,test@example.com test@example..com]
    invalid_addresses.each do |address|
      @contact.email = address
      assert_not @contact.valid? 
    end
  end

  test "shoud accept valid email format" do
    invalid_addresses = %w[test@example.com test@example.com]
    invalid_addresses.each do |address|
      @contact.email = address
      assert @contact.valid? 
    end
  end

  test "should presence contact message" do
    @contact.message = ""
    assert_not @contact.valid?
  end

  test "should presence contact categry" do
    @contact.category = ""
    assert_not @contact.valid?
  end

  test "should presence contact reply when create" do
    @contact.reply = ""
    assert @contact.valid?
  end

  test "valid contact information" do
    assert @contact.valid?
  end

  test "order should be first recent contact" do
    assert_equal contacts(:recent_contact), Contact.first
  end
end
