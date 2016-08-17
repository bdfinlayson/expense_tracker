class AddNoteToRecurringIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :recurring_incomes, :note, :text
  end
end
