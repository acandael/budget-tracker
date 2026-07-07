class AddUserToBudgets < ActiveRecord::Migration[8.1]
  def change
    add_reference :budgets, :user, null: true, foreign_key: true
  end
end
