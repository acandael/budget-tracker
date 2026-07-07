class CopyRecurringTransactionsJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      previous_budget = user.budgets.where("month < ?", Date.current.beginning_of_month).order(month: :desc).first

      return unless previous_budget

      current_budget = user.budgets.find_or_create_by(month: Date.current.beginning_of_month)

      previous_budget.transactions.recurring.each do |transaction|
        current_budget.transactions.create!(
          name: transaction.name,
          amount: transaction.amount,
          transaction_type: transaction.transaction_type,
          recurring: true,
          due_date: transaction.due_date + 1.month
        )
      end
    end
  end
end
