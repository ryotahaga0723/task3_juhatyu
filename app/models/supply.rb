class Supply < ApplicationRecord
  self.primary_key = :code
  
  belongs_to :product
  belongs_to :stock
  has_many :order_supplies, dependent: :destroy
  has_many :orders, through: :order_supplies


  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true
  validates :set, presence: true
end
