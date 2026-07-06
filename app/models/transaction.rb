class Transaction < ApplicationRecord
  belongs_to :budget

  enum :transaction_type, { expense: 0, income: 1 }

  def self.types_for_select
    transaction_types.keys.map { [ it.capitalize, it ] }
  end

  def formatted_due_date
    due_date.strftime("%b %d, %Y")
  end
end
