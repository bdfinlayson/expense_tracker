class CreateIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :incomes do |t|
      t.float :amount
      t.integer :user_id
      t.boolean :recurring, default: false
      t.integer :frequency
      t.integer :vendor_id

      t.timestamps
    end
  end
end
