class Transaction < ApplicationRecord
  self.inheritance_column = :_type_disabled
  enum type: { credit: 'credit', debit: 'debit' }
  enum status: { pending: 'pending', completed: 'completed', failed: 'failed' }
  validates :invoice, uniqueness: true, length: { is: 8 }
  before_validation :generate_invoice, on: :create

  private

  def generate_invoice
    self.invoice ||= loop do
      random = "%08d" % rand(10**8)
      break random unless Transaction.exists?(invoice: random)
    end
  end
end
