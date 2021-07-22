# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

d = Date.today

User.create({username: "Cookie Monster", password: "I love cookies", age: 63})

1.upto(10) do |i|
  Expense.create({title: "Expense No.#{i}", amount: (i + i*10), date: (d-i).to_s, user_id: 1})
end

1.upto(20) do |i|
  Income.create({title: "Income No.#{i}", amount: (i + i*100), date: (d-i).to_s, user_id: 1})
end