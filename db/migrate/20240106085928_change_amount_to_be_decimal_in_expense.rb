class ChangeAmountToBeDecimalInExpense < ActiveRecord::Migration[7.1]
  def up
    change_column :expenses, :amount, :decimal
  end

  def down
    change_column :expenses, :amount, :float
  end
end
