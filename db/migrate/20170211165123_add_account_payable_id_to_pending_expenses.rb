class AddAccountPayableIdToPendingExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :pending_expenses, :account_payable_id, :integer
    add_index :pending_expenses, :account_payable_id
  end
end
