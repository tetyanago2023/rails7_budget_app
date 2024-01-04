json.extract! expense, :id, :date, :name, :description, :amount, :created_at, :updated_at
json.url expense_url(expense, format: :json)
