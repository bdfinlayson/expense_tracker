class AddArchivedToRecurringIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :recurring_incomes, :archived, :boolean, default: false
    add_index :recurring_incomes, :archived
  end
end
