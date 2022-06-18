User.create!(
  name: Rails.application.credentials[:admin][:user_name],
  password: Rails.application.credentials[:admin][:password],
  password_confirmation: Rails.application.credentials[:admin][:password],
  admin: true
) 

12.times do |n|
  Micropost.create!(
    title: "#{n}月の営業日のお知らせ",
    content: "１日,２日\n8日,9日\n15日,16日はお休みになります",
    user_id: 1
  ) 
end

12.times do |n|
  Contact.create!(
    name: "recent test #{n} user",
    email: "recent#{n}@example.com",
    message: "test inquiry contact #{n} message",
    category: "商品について"
  ) 
end