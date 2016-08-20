class AddFrequencyToRecurringIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :recurring_incomes, :frequency, :integer
    add_index :recurring_incomes, :frequency
  end
end
