class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many :invoice_contents
  has_one :approval, as: :approvalable
  has_one :address, as: :addressable
  has_one :telephone, as: :telephoneable


  validates :code, presence: true, uniqueness: true
  validates_associated :invoice_contents

  accepts_nested_attributes_for :invoice_contents
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :telephone
end
