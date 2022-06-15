class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :code, null: false, unique: true
      t.bigint :user_id, null: false, index: true, foreign_key: true
      t.bigint :order_id, null: false, index: true, foreign_key: true
      t.bigint :total_sum

      t.timestamps
    end
  end
end
