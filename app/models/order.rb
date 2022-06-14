class Order < ApplicationRecord
  validates :date, presence: true
  self.primary_key = :code

  belongs_to :user
  has_many :order_supplies, dependent: :destroy
  has_many :supplies, through: :order_supplies
  has_one :address, as: :addressable
  has_one :telephone, as: :telephoneable
  has_one :shipping, dependent: :destroy

  accepts_nested_attributes_for :order_supplies
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :telephone
  accepts_nested_attributes_for :shipping
  validates_associated :order_supplies
  validates_associated :address
  validates_associated :telephone
  validates_associated :shipping

end
