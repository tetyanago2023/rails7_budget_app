class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.date :date
      t.string :name
      t.text :description
      t.float :amount

      t.timestamps
    end
  end
end
