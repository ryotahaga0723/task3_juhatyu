class Shipping < ApplicationRecord
  belongs_to :order

  validates :name, presence: true
end
