class AddBeginningCashOnHandToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :beginning_cash_on_hand, :float
  end
end
