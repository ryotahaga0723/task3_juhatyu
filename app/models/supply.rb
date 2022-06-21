class Supply < ApplicationRecord
  belongs_to :product
  belongs_to :stock
  has_many :order_supplies, dependent: :destroy
  has_many :orders, through: :order_supplies
  has_one :cancel, dependent: :destroy

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true
  validates :set, presence: true

  def avarage
    if order_supplies.present?
    order_supplies.average(:quantity).round(1)
    end
  end

end
