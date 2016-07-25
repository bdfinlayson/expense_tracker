class AddRecurringAndFrequencyToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :recurring, :boolean, default: false
    add_column :expenses, :frequency, :integer
  end
end
