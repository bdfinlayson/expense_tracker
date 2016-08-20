class AddIncomeCategoryIdToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :incomes, :income_category_id, :integer
    add_index :incomes, :income_category_id
  end
end
