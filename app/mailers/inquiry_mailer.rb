class InquiryMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to: contact.email, bcc: ENV['SMTP_USERNAME'], subject: "【穂高共同食品】お問い合わせ受付報告のお知らせ"
  end

  def reply_mail(contact)
    @contact = contact
    mail to: contact.email, subject: "【穂高共同食品】お問い合わせへのご回答"
  end
end
