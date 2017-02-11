class AddAccountPayableIdToRecurringExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :recurring_expenses, :account_payable_id, :integer
    add_index :recurring_expenses, :account_payable_id
  end
end
