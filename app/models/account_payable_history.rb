class AccountPayableHistory < ApplicationRecord
  include BaseModel
  belongs_to :account_payable
  belongs_to :expense
end
