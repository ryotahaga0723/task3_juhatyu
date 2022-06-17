class Payee < ApplicationRecord
  belongs_to :company

  validates :bank, presence: true
  validates :branch, presence: true
  validates :kind, presence: true
  validates :number, presence: true

  enum kind: {普通:0, 当座:1}

end
