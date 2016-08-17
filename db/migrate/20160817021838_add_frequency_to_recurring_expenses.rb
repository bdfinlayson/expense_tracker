class AddFrequencyToRecurringExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :recurring_expenses, :frequency, :integer
    add_index :recurring_expenses, :frequency
  end
end
