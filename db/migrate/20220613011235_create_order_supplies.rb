class CreateOrderSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :order_supplies do |t|
      t.boolean :availability, null:false, default: false
      t.bigint :quantity, null: false
      t.bigint :order_id, null: false, index: true, foreign_key: true
      t.bigint :supply_id, null: false, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
