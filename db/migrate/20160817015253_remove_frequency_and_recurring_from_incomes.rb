class RemoveFrequencyAndRecurringFromIncomes < ActiveRecord::Migration[5.0]
  def change
    remove_column :incomes, :frequency, :integer
    remove_column :incomes, :recurring, :boolean
  end
end
