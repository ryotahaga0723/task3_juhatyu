class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.string :name, null: false
      t.bigint :order_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
