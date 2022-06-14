class Delivery < ApplicationRecord
  belongs_to :order

  validates :arrive_date, presence: true
  validates :delivery_company, presence: true, length: { maximum: 255 }
  validates :delivery_number, presence: true

end
