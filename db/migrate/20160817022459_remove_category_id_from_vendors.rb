class RemoveCategoryIdFromVendors < ActiveRecord::Migration[5.0]
  def change
    remove_column :vendors, :category_id, :integer
  end
end
