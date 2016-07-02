class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.integer :user_id
      t.string :city
      t.string :state
      t.integer :category_id
      t.text :note

      t.timestamps
    end
    add_index :vendors, :user_id
    add_index :vendors, :category_id
  end
end
