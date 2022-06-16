class CreateOrderWills < ActiveRecord::Migration[6.0]
  def change
    create_table :order_wills do |t|
      t.bigint :quantity, default: 0
      t.bigint :order_id, null: false, index: true, foreign_key: true
      t.bigint :product_id, null: false, index: true, foreign_key: true


      t.timestamps
    end
  end
end
