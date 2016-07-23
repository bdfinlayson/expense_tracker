class CreateBudgets < ActiveRecord::Migration[5.0]
  def change
    create_table :budgets do |t|
      t.integer :amount
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
