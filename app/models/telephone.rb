class Telephone < ApplicationRecord
  validates :number, presence: true, uniqueness: true, format: { with: /\A\d{10}$|^\d{11}\z/ }

  belongs_to :telephoneable, polymorphic: true
end
