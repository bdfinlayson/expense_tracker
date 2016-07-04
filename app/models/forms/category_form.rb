class CategoryForm < Reform::Form
  property :name
  property :ancestry

  validates :name, presence: true
end
