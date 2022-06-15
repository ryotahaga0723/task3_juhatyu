class CreateSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :supplies do |t|
      t.string :code, null: false,  unique: true
      t.string :name, null: false
      t.bigint :price, null: false
      t.bigint :set, null: false
      t.string :content
      t.bigint :product_id, null: false, index: true, foreign_key: true
      t.bigint :stock_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
