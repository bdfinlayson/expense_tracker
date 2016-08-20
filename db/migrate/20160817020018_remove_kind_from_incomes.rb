class RemoveKindFromIncomes < ActiveRecord::Migration[5.0]
  def change
    remove_column :incomes, :kind, :integer
  end
end
