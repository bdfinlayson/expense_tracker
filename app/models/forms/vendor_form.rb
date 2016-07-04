class VendorForm < Reform::Form
  property :name
  property :note
  property :user_id

  validates :name, presence: true
  validates :user_id, presence: true
end
