# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

24.times do |n|
  name = Faker::JapaneseMedia::StudioGhibli.character
  introduction = Faker::JapaneseMedia::StudioGhibli.quote
  email = Faker::Internet.email
  user = User.create(
    name: name,
    email: email,
    password: "password",
    introduction: introduction
  )
  book_amount = rand(1..5)
  book_amount.times do |i|
    title = Faker::Movie.title
    body = Faker::Movie.quote
    Book.create(
      title: title,
      body: body,
      user_id: user.id
    )
  end
end
User.create(name: "abe", email: "abe@abe", password: "abeabe")