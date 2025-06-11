# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
# db/seeds.rb

# db/seeds.rb

# db/seeds.rb

# Clear existing data (idempotent)
Transaction.delete_all

# Generate 100 unique transactions
(1..100).each do |i|
  invoice = format("%08d", 10000000 + i)
  timestamp = Time.now.to_i - (rand(90) * 86400) # Random day within last 90 days
  status = ['completed', 'pending', 'failed'].sample
  type = ['credit', 'debit'].sample
  mobile = "+91#{rand(9000000000..9999999999)}"

  Transaction.create!(
    type: type,
    invoice: invoice,
    timestamp: timestamp,
    mobile: mobile,
    status: status
    # created_at and updated_at will be set automatically unless you need to override
  )
end

puts "Seeded #{Transaction.count} transactions."
