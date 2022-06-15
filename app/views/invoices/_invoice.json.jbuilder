json.extract! invoice, :id, :code, :user_id, :order_id, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
