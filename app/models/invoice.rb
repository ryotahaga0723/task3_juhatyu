class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many :invoice_contents
  has_one :approval, as: :approvalable

  validates :code, presence: true, uniqueness: true
  validates_associated :invoice_contents

  accepts_nested_attributes_for :invoice_contents
end
