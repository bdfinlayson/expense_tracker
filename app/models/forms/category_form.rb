require 'reform/form/coercion'

class CategoryForm < Reform::Form
  feature Coercion
  property :name
  property :user_id

  validates :name, presence: true
  validates :user_id, presence: true
end
