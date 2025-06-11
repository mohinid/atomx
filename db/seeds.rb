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

Transaction.delete_all

sample_transactions = [
  {
    type: 'credit',
    invoice: '10000001',
    timestamp: 1717802400, # Example UNIX timestamp (2025-06-08 10:00:00 UTC)
    mobile: '9876543210',
    status: 'completed',
    created_at: '2025-06-08 10:00:00',
    updated_at: '2025-06-08 10:00:00'
  },
  {
    type: 'debit',
    invoice: '10000002',
    timestamp: 1717888800, # 2025-06-09 10:00:00 UTC
    mobile: '9876543211',
    status: 'pending',
    created_at: '2025-06-09 10:00:00',
    updated_at: '2025-06-09 10:00:00'
  },
  {
    type: 'credit',
    invoice: '10000003',
    timestamp: 1717975200, # 2025-06-10 10:00:00 UTC
    mobile: '9876543212',
    status: 'failed',
    created_at: '2025-06-10 10:00:00',
    updated_at: '2025-06-10 10:00:00'
  },
  {
    type: 'debit',
    invoice: '10000004',
    timestamp: 1718061600, # 2025-06-11 10:00:00 UTC
    mobile: '9876543213',
    status: 'completed',
    created_at: '2025-06-11 10:00:00',
    updated_at: '2025-06-11 10:00:00'
  },
  {
    type: 'credit',
    invoice: '10000005',
    timestamp: 1718148000, # 2025-06-12 10:00:00 UTC
    mobile: '9876543214',
    status: 'pending',
    created_at: '2025-06-12 10:00:00',
    updated_at: '2025-06-12 10:00:00'
  }
]

sample_transactions.each do |attrs|
  Transaction.create!(attrs)
end

puts "Seeded #{Transaction.count} transactions."
