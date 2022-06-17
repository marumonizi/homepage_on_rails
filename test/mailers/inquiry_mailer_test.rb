require "test_helper"

class ContactMailerTest < ActionMailer::TestCase
  
  test "send mail" do
    contact =  Contact.new(name: "テスト", email: "test@exmaple.com", message: "お問い合わせしました。ご回答お願いします")
    mail = InquiryMailer.send_mail(contact)
    assert_equal ['keutya@gmail.com'], mail.from
    assert_equal [contact.email], mail.to
    assert_equal "【穂高共同食品】お問い合わせ受付報告のお知らせ", mail.subject
    assert_match contact.name, mail.text_part.body.encoded
    assert_match contact.name, mail.html_part.body.encoded
    assert_match contact.message, mail.text_part.body.encoded
    assert_match contact.message, mail.html_part.body.encoded
    assert_match contact.email, mail.text_part.body.encoded
    assert_match contact.email, mail.html_part.body.encoded
  end

  test "reply mail" do
    contact =  Contact.new(name: "テスト", email: "test@exmaple.com", message: "お問い合わせしました。ご回答お願いします")
    contact.update_attribute(:reply, "お問い合わせありあがとうございます。")
    mail = InquiryMailer.reply_mail(contact)
    assert_equal ['keutya@gmail.com'], mail.from
    assert_equal [contact.email], mail.to
    assert_equal "【穂高共同食品】お問い合わせへのご回答", mail.subject
    assert_match contact.reply, mail.text_part.body.encoded
    assert_match contact.reply, mail.html_part.body.encoded
    assert_match contact.name, mail.text_part.body.encoded
    assert_match contact.name, mail.html_part.body.encoded
    assert_match contact.message, mail.text_part.body.encoded
    assert_match contact.message, mail.html_part.body.encoded
    assert_match contact.email, mail.text_part.body.encoded
    assert_match contact.email, mail.html_part.body.encoded
  end
end
