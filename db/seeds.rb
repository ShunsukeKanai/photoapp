Faker::Config.locale = :en

# ゲストユーザー作成
User.create!(name: "guest",
             email: "guest@example.com",
             introduction: "私はゲストユーザーです。",
             password: "password",
             password_confirmation: "password",
             confirmed_at: Date.today
            )

# サンプルユーザー作成
20.times do |n|
  name  = Faker::Name.name
  email = "sample#{n+1}@sample.com"
  introduction = Faker::GreekPhilosophers.quote
  password = "password"
  User.create!(name:  name,
               email: email,
               introduction: introduction,
               avatar: open("#{Rails.root}/db/images/user#{n % 10 + 1}.jpg"),
               password:              password,
               password_confirmation: password,
               confirmed_at: Date.today
              )
end

# サンプル投稿作成
users = User.order(:created_at).take(21)

200.times do |n|
  image = open("#{Rails.root}/db/images/image#{rand(1..22)}.jpg")
  description = Faker::JapaneseMedia::SwordArtOnline.location
  users[n % 21].posts.create!(image: image,
                              description: description,
                              created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
                             )
end
