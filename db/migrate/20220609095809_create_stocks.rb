class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.bigint :quantity, null: false
      t.bigint :company_id, null: false, index: true, foreign_key: true
      t.bigint :user_id, null: false, index: true, foreign_key: true
      t.bigint :product_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
