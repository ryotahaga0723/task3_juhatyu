class Company < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  self.primary_key = :code
  has_many :users, dependent: :destroy
  has_one :address, as: :addressable

  accepts_nested_attributes_for :address

end
