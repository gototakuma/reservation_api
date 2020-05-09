User.create(
  name: "管理者",
  email: "admin@email.com",
  password_digest: "$2a$10$HjQH2VBdguACJLyZHoVSs.yBZbwypqY3vUJGnxlWj94rmilWIuWzK",
  age: 20,
  sex: "女",
  position: "admin",
  deleted_at: nil
  )
puts "管理者作成"

5.times do |n|
  User.create(
    name: "test#{n+1}",
    email: "sample#{n+1}@email.com",
    password_digest: "$2a$10$HjQH2VBdguACJLyZHoVSs.yBZbwypqY3vUJGnxlWj94rmilWIuWzK",
    age: (n+1)*5,
    sex: "男",
    position: "user",
    deleted_at: nil
  )
end
puts "ユーザー作成"

Staff.create(
  name: "スタッフ1",
  age: 28,
  description: "カット大好き〜",
  sex: "男",
  img: open("#{Rails.root}/db/fixtures/bm1.jpg")
)
puts "スタッフ(男)作成"

Staff.create(
  name: "スタッフ2",
  age: 24,
  description: "接客大好き〜",
  sex: "女",
  img: open("#{Rails.root}/db/fixtures/bw1.jpg")
)
puts "スタッフ(女)作成"

Cource.create(
  cource: "カット",
  time: 60,
  price: 4500
)
Cource.create(
  cource: "パーマ",
  time: 30,
  price: 3000
)
Cource.create(
  cource: "カラー",
  time: 40,
  price: 5000
)
puts "コース作成"