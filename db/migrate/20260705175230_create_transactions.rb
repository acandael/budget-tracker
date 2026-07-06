class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.references :budget, null: false, foreign_key: true
      t.string :name
      t.decimal :amount, precision: 10, scale: 2
      t.date :due_date
      t.integer :transaction_type

      t.timestamps
    end
  end
end
