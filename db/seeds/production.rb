User.create!(
  name: Rails.application.credentials[:admin][:user_name],
  password: Rails.application.credentials[:admin][:password],
  password_confirmation: Rails.application.credentials[:admin][:password],
  admin: true
)