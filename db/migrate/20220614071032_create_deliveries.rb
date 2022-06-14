class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.datetime :arrive_date, null: false
      t.string :delivery_company, null: false
      t.bigint :delivery_number, null: false
      t.bigint :order_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
