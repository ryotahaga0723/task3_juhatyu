class OrderSupply < ApplicationRecord
  belongs_to :order
  belongs_to :supply
  has_one :status, dependent: :destroy

  validates :quantity, presence: true, if: -> { availability == true }

  accepts_nested_attributes_for :status

  def selectable_supplies
    Supply.all
  end
end
