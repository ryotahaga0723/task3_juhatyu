class OrderSupply < ApplicationRecord
  belongs_to :order
  belongs_to :supply

  validates :quantity, presence: true, if: -> { availability == true }

  def selectable_supplies
    Supply.all
  end
end
