# spec/factories/transactions.rb
FactoryBot.define do
  factory :transaction do
    type { "credit" }
    status { "pending" }
    invoice { SecureRandom.random_number(10**8).to_s.rjust(8, '0') }
    timestamp { Time.now.to_i }
    mobile { "9876543210" }
    created_at { Time.now }
  end
end
