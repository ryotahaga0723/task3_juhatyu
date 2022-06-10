class Supply < ApplicationRecord
  self.primary_key = :code
  
  belongs_to :product
  belongs_to :stock

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true
  validates :set, presence: true

end
