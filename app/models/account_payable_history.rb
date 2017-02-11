class AccountPayableHistory < ApplicationRecord
  belongs_to :account_payable
  belongs_to :expense
end
