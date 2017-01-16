class AddArchivedToRecurringExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :recurring_expenses, :archived, :boolean, default: false
    add_index :recurring_expenses, :archived
  end
end
