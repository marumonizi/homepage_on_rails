User.create!(
  name: Rails.application.credentials[:admin][:user_name],
  password: Rails.application.credentials[:admin][:password],
  password_confirmation: Rails.application.credentials[:admin][:password],
  email: Rails.application.credentials[:admin][:email],
  admin: true,
  activated: true
)