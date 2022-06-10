class Stock < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :company
  belongs_to :user
  belongs_to :product
  has_many :supplies, dependent: :destroy

end
