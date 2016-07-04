class RemoveCityAndStateFromVendors < ActiveRecord::Migration[5.0]
  def change
    remove_column :vendors, :city, :string
    remove_column :vendors, :state, :string
  end
end
