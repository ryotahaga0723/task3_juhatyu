class Product < ApplicationRecord
  belongs_to :company
  belongs_to :category
  has_one :stock, dependent: :destroy
  has_many :supplies, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :stock, reject_if: :all_blank, allow_destroy: true

  validates_associated :stock
  validates :name, presence: true
end
