class Budget < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  def formatted_month
    month.strftime("%B %Y")
  end

  def total_income
    transactions.income.sum(:amount)
  end

  def total_expenses
    transactions.expense.sum(:amount)
  end

  def remaining_balance
    total_income - total_expenses
  end
end
