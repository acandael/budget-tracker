user = User.create!(email_address: "demo@example.com", password: "password")
budget = user.budgets.create!(month: Date.today.beginning_of_month)

[
  { transaction_type: :income,  amount: 3000.00, name: "Salary",             due_date: budget.month },
  { transaction_type: :income,  amount:  500.00, name: "Freelance project",  due_date: budget.month + 7.days },
  { transaction_type: :income,  amount:   85.00, name: "Birthday money",     due_date: budget.month + 14.days },
  { transaction_type: :expense, amount: 1200.00, name: "Rent",               due_date: budget.month + 1.day },
  { transaction_type: :expense, amount:   85.50, name: "Electric bill",      due_date: budget.month + 2.days },
  { transaction_type: :expense, amount:   60.00, name: "Internet",           due_date: budget.month + 3.days },
  { transaction_type: :expense, amount:  120.75, name: "Groceries",          due_date: budget.month + 5.days },
  { transaction_type: :expense, amount:   45.00, name: "Streaming services", due_date: budget.month + 8.days },
  { transaction_type: :expense, amount:  200.00, name: "Gas",                due_date: budget.month + 10.days },
  { transaction_type: :expense, amount:   75.25, name: "Dining out",         due_date: budget.month + 12.days }
].each do |attrs|
  budget.transactions.create!(attrs)
end
