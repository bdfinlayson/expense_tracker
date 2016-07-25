class AddKindToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :incomes, :kind, :integer
  end
end
