class RemoveTypeFromIncomes < ActiveRecord::Migration[5.0]
  def change
    remove_column :incomes, :type, :integer
  end
end
