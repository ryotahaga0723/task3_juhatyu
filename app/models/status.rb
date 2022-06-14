class Status < ApplicationRecord
  belongs_to :order

  enum status: {受注確認待ち:0, 発送待ち:1, 発送中:2, 請求書作成待ち:3, 請求書送付済み:4, 受注不可:5, 確認中:6}

end
