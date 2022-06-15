class User < ApplicationRecord  
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6, maximum: 255 }

  belongs_to :company, primary_key: :code
  has_many :stocks, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :invoices, dependent: :destroy

end
