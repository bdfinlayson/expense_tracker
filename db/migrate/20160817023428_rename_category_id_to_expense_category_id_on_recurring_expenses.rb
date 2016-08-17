class RenameCategoryIdToExpenseCategoryIdOnRecurringExpenses < ActiveRecord::Migration[5.0]
  def change
    rename_column :recurring_expenses, :category_id, :expense_category_id
  end
end
