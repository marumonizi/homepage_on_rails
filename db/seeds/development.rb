User.create!(
  name: Rails.application.credentials[:admin][:user_name],
  password: Rails.application.credentials[:admin][:password],
  password_confirmation: Rails.application.credentials[:admin][:password],
  email: Rails.application.credentials[:admin][:email],
  admin: true,
  activated: true
) 

User.create!(
  name: "安曇野太郎",
  password: "password123",
  password_confirmation: "password123",
  email: "azumino@taro.com",
  activated: true,
  activated_at: Time.zone.now
)

12.times do |n|
  Micropost.create!(
    title: "#{n}月の営業日のお知らせ",
    content: "１日,２日\n8日,9日\n15日,16日はお休みになります",
    user_id: 1,
    image: File.open("./app/assets/images/sioyaki.jpg")
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

5.times do |n|
  Product.create!(
    name: "虹鱒の塩焼き #{n} ",
    price: 300,
    images: [File.open("./app/assets/images/sioyaki.jpg"),File.open("./app/assets/images/mizu.png"),File.open("./app/assets/images/Iwana.jpg")],
    introduction: "あ" * 100
  ) 
end