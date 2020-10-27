# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

return unless Rails.env.development?

[
  {
    name: "hoge",
    email: "hoge@sample.com",
    password: "Password"
  },
  {
    name: "foo",
    email: "foo@sample.com",
    password: "Password"
  }
].each {|params|
  User.create!(params)
}
