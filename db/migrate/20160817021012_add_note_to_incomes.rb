class AddNoteToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :incomes, :note, :text
  end
end
