class Category < ApplicationRecord
  validates_presence_of :name, :category_type, :user_id
end
