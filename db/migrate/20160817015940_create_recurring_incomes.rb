class CreateRecurringIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :recurring_incomes do |t|
      t.float :amount
      t.integer :user_id
      t.integer :vendor_id
      t.integer :income_category_id

      t.timestamps
    end
    add_index :recurring_incomes, :user_id
    add_index :recurring_incomes, :vendor_id
    add_index :recurring_incomes, :income_category_id
  end
end
