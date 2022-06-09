class Company < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  self.primary_key = :code
  has_many :users, dependent: :destroy
  has_one :address, as: :addressable
  has_one :telephone, as: :telephoneable

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :telephone

end
