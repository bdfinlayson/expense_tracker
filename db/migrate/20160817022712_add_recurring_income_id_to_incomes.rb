class AddRecurringIncomeIdToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :incomes, :recurring_income_id, :integer
    add_index :incomes, :recurring_income_id
  end
end
