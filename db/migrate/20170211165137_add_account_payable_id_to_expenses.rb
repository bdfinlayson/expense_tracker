class AddAccountPayableIdToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :account_payable_id, :integer
    add_index :expenses, :account_payable_id
  end
end
