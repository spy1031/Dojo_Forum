# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#================== Create default user ==============#
User.create(name: "admin", email: "admin@example.com", password: "12345678", role: "admin")

#================== Create default category =============#
category_list = %w(戰士 薩滿 盜賊 聖騎士 獵人 德魯伊 術師 法師 牧師)

category_list.each do |category|
  Category.create(content: category)
end