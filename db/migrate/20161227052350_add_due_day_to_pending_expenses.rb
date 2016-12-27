class AddDueDayToPendingExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :pending_expenses, :due_day, :integer
    add_index :pending_expenses, :due_day
  end
end
