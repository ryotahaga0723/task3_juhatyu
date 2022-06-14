class Schedule < ApplicationRecord
  belongs_to :order

  validates :date, presence: true
  validates :what, presence: true
  validates :do, presence: true

  enum check_list: {□:0, check:1}

end
