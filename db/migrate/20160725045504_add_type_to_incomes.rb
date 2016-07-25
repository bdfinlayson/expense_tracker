class AddTypeToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :incomes, :type, :integer
  end
end
