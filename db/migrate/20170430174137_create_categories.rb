class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :category_type
      t.integer :user_id

      t.timestamps
    end
    add_index :categories, :name
    add_index :categories, :category_type
    add_index :categories, :user_id
  end
end
