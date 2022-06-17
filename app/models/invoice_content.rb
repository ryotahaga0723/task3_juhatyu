class InvoiceContent < ApplicationRecord
  belongs_to :invoice

  validates :name, presence: true
  validates :set, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :code, presence: true

end
