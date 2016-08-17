class AddIndexToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_index :incomes, :user_id
    add_index :incomes, :vendor_id
  end
end
