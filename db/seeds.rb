# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: "guest@i.co.jp", password: "swim40")

(1..10).each do |i|
  User.create!(
    name: "user_#{i}",
    email: "user_#{i}@test.com",
    password: "password"
  )
end

titles = [ "基礎フォーム練習", "クロール基礎練習", "背泳ぎフォーム練習" ]
contents =  ["アップ200m→キック400m→プル400m→スイム400m", "アップ200m→キック200m→プル200m→スイム200m", "アップ200m→キック25m×8本→プル50m×4本→スイム200m"]
User.all.limit(3).each do |user|
  3.times do |m|
    (1..28).each do |d|
      if rand(0..2) == 0
        date_time = m.months.before - d.day
        user.posts.create!(
          title: titles.sample,
          content: contents.sample,
          distance: rand(1..3) * 100,
          stroke: rand(0..3),
          time: rand(3..12) * 10,
          practice_day: date_time = m.months.before - d.day
        )
      end
    end
  end
end
