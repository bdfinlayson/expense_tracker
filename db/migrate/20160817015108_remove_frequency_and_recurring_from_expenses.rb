class RemoveFrequencyAndRecurringFromExpenses < ActiveRecord::Migration[5.0]
  def change
    remove_column :expenses, :frequency, :integer
    remove_column :expenses, :recurring, :boolean
  end
end
