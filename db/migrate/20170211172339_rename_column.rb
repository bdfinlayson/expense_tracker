class RenameColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :account_payable_histories, :transation_amount, :transaction_amount
  end
end
