class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.string :invoice
      t.integer :timestamp
      t.string :mobile
      t.string :status

      t.timestamps
    end
    add_index :transactions, :invoice, unique: true
  end
end
