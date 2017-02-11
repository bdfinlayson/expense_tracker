class CreateAccountPayableHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :account_payable_histories do |t|
      t.integer :expense_id
      t.integer :account_payable_id
      t.float :starting_amount
      t.float :ending_amount
      t.float :transation_amount

      t.timestamps
    end
    add_index :account_payable_histories, :expense_id
    add_index :account_payable_histories, :account_payable_id
  end
end
