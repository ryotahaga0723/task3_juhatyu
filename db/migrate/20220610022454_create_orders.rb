class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :code, null: false, unique: true
      t.date :date, null: false
      t.bigint :total_price
      t.bigint :user_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
