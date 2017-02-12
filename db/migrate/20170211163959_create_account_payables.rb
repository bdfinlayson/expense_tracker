class CreateAccountPayables < ActiveRecord::Migration[5.0]
  def change
    create_table :account_payables do |t|
      t.float :starting_amount
      t.float :current_amount
      t.string :name
      t.integer :user_id
      t.date :interest_free_expiration_at
      t.date :opened_at
      t.date :closed_at
      t.integer :vendor_id

      t.timestamps
    end
    add_index :account_payables, :name
    add_index :account_payables, :user_id
    add_index :account_payables, :vendor_id
  end
end
