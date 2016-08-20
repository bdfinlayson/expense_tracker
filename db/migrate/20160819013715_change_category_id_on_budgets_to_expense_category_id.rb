class ChangeCategoryIdOnBudgetsToExpenseCategoryId < ActiveRecord::Migration[5.0]
  def change
    rename_column :budgets, :category_id, :expense_category_id
  end
end
