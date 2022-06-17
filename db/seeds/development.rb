User.create!(
  name: ENV['ADMIN_USER'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
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