class ApplicationMailer < ActionMailer::Base
  default from: "穂高共同食品 <#{Rails.application.credentials[:google][:user_name]}>"
  layout 'mailer'
end
