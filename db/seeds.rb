# coding: utf-8

User.create!(name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)

50.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
end

# サンプルのメニューを作成
MenuItem.create!(
  menu_name: "調髪",
  price: 3600,
  order: 000
)

MenuItem.create!(
  menu_name: "調髪（シャンプーなし",
  price: 3300,
  order: 001
)

MenuItem.create!(
  menu_name: "調髪（顔剃なし）",
  price: 3000,
  order: 002
)