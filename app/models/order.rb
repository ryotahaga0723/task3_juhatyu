class Order < ApplicationRecord
  validates :date, presence: true
  self.primary_key = :code

  belongs_to :user
end
