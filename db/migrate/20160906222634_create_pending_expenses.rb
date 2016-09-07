class CreatePendingExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :pending_expenses do |t|
      t.float :amount
      t.integer :user_id
      t.integer :vendor_id
      t.integer :expense_category_id
      t.text :note
      t.integer :recurring_expense_id

      t.timestamps
    end
    add_index :pending_expenses, :user_id
    add_index :pending_expenses, :vendor_id
    add_index :pending_expenses, :expense_category_id
    add_index :pending_expenses, :recurring_expense_id
  end
end
