class AccountPayable < ApplicationRecord
  include BaseModel
  belongs_to :user
  belongs_to :vendor
  has_many :payments, foreign_key: 'account_payable_id', class_name: 'Expense'
  has_many :logs, foreign_key: 'account_payable_id', class_name: 'AccountPayableHistory'

  scope :active, -> { where(closed_at: nil) }

  def log_transaction(payment)
    starting_amount = self.current_amount
    ending_amount = starting_amount - payment.amount
    self.update(current_amount: ending_amount)
    AccountPayableHistory.create(
      account_payable: self,
      starting_amount: starting_amount,
      ending_amount: ending_amount,
      transaction_amount: payment.amount,
      expense: payment
    )
  end
end
