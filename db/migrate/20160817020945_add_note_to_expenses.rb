class AddNoteToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :note, :text
  end
end
