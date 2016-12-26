class AddDueDayToRecurringIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :recurring_incomes, :due_day, :integer
    add_index :recurring_incomes, :due_day
  end
end
