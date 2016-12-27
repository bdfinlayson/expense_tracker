class RemoveDueDayFromPendingExpenses < ActiveRecord::Migration[5.0]
  def change
    remove_index :pending_expenses, :due_day
    remove_column :pending_expenses, :due_day, :integer
  end
end
