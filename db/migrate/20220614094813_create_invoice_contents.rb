class CreateInvoiceContents < ActiveRecord::Migration[6.0]
  def change
    create_table :invoice_contents do |t|
      t.string :name, null: false
      t.bigint :set, null: false
      t.bigint :price, null: false
      t.bigint :quantity, null: false
      t.bigint :invoice_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
