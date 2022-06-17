# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
  def send_mail
    contact = Contact.first
    InquiryMailer.send_mail(contact)
  end

  def reply_mail
    contact = Contact.first
    contact.update_attribute(:reply, "お問い合わせありがとうございます。以上よろしくお願いします")
    InquiryMailer.reply_mail(contact)
  end
end
