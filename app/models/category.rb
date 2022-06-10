class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  belongs_to :company
  has_many :products
end
