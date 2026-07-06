# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this app is

Tally is a personal budget tracker built with Rails 8.1. Users create monthly `Budget` records and attach `Transaction` entries (income/expense) with a name, amount, due date, and type. The root route lands on the budgets index.

## Tech stack

- **Ruby** 3.4.10 (set in `.ruby-version`)
- **Rails** 8.1 with Propshaft (asset pipeline), Importmap, Hotwire (Turbo + Stimulus)
- **PostgreSQL** — dev DB: `tally_development`, test DB: `tally_test`
- **Solid Cache / Queue / Cable** — database-backed adapters (no Redis)
- **Deployment** via Kamal + Thruster (Docker)

## Common commands

```bash
bin/dev                    # start the Rails server
bin/rails test             # run the full test suite
bin/rails test test/models/budget_test.rb  # run a single test file
bin/rails test test/controllers/budgets_controller_test.rb:20  # run one test by line
bin/rails db:migrate       # run pending migrations
bin/rails db:seed:replant  # reset and re-seed (also run by CI)
bin/ci                     # full CI pipeline: setup, rubocop, security scans, tests
bin/rubocop                # lint Ruby (omakase style)
bin/brakeman --quiet       # static security analysis
bin/bundler-audit          # audit gems for known CVEs
```

## Domain model

```
Budget
  has_many :transactions, dependent: :destroy
  month  :date          # represents a calendar month (formatted via #formatted_month)

Transaction
  belongs_to :budget
  name             :string
  amount           :decimal(10,2)
  due_date         :date
  transaction_type :integer   # enum — income vs expense (values TBD)
```

Transactions are nested under budgets in the routes (`/budgets/:budget_id/transactions/...`), but the `TransactionsController` currently operates without the budget scope — something to be aware of when adding budget-scoped logic.

## CI pipeline

`bin/ci` runs these steps in order:

1. `bin/setup --skip-server`
2. `bin/rubocop` — style
3. `bin/bundler-audit` — gem CVEs
4. `bin/importmap audit` — JS dependency CVEs
5. `bin/brakeman` — static security
6. `bin/rails test` — unit + integration tests
7. `bin/rails db:seed:replant` (in test env) — seed smoke test

System tests (`bin/rails test:system`, uses Capybara + Selenium) are available but excluded from CI by default.
