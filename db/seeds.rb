# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create expenses for all months
(1..12).each do |month|
  Expense.create(
    date: Date.new(2024, month, rand(1..28)),
    name: "Expense for #{Date::MONTHNAMES[month]}",
    amount: rand(100),
    description: "#{Date::MONTHNAMES[month]} expenses description"
  )
end

