class AddDueDayToRecurringExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :recurring_expenses, :due_day, :integer
    add_index :recurring_expenses, :due_day
  end
end
