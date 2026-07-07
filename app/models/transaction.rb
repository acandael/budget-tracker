class Transaction < ApplicationRecord
  belongs_to :budget

  enum :transaction_type, { expense: 0, income: 1 }

  scope :recurring, -> { where(recurring: true) }

  validates :name, :due_date, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.00 }

  def self.types_for_select
    transaction_types.keys.map { [ it.capitalize, it ] }
  end

  def formatted_due_date
    due_date.strftime("%b %d, %Y")
  end
end
