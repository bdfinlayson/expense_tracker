class RenameCategoriesToExpenseCategories < ActiveRecord::Migration[5.0]
  def change
    rename_table :categories, :expense_categories
  end
end
