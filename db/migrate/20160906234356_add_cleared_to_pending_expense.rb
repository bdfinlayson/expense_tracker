class AddClearedToPendingExpense < ActiveRecord::Migration[5.0]
  def change
    add_column :pending_expenses, :cleared, :boolean, default: false
  end
end
