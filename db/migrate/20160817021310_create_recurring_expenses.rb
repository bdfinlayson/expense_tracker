class CreateRecurringExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :recurring_expenses do |t|
      t.float :amount
      t.integer :user_id
      t.integer :vendor_id
      t.integer :category_id
      t.text :note

      t.timestamps
    end
    add_index :recurring_expenses, :user_id
    add_index :recurring_expenses, :vendor_id
    add_index :recurring_expenses, :category_id
  end
end
