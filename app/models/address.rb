class Address < ApplicationRecord
  validates :postcode, presence: true
  validates :prefecture, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :town, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :building, length: { maximum: 255 }

  belongs_to :addressable, polymorphic: true
end
