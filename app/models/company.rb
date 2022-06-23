class Company < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :code, presence: true, uniqueness: true


  self.primary_key = :code
  has_many :users, dependent: :destroy
  has_one :address, as: :addressable
  has_one :telephone, as: :telephoneable
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_one :payee, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :telephone

end
