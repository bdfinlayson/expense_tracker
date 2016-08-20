class AddRecurringExpenseIdToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :recurring_expense_id, :integer
    add_index :expenses, :recurring_expense_id
  end
end
