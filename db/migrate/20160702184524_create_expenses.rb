class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.float :amount
      t.integer :vendor_id

      t.timestamps
    end
    add_index :expenses, :user_id
    add_index :expenses, :vendor_id
  end
end
