class Status < ApplicationRecord
  belongs_to :order

  enum status: {新規受付:0, 発送待ち:1, 発送中:2, 請求書作成待ち:3, 請求書承認待ち:4, 請求書送付済み:5, 受注不可:6}

end
