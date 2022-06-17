class CreatePayees < ActiveRecord::Migration[6.0]
  def change
    create_table :payees do |t|
      t.string :bank, null: false
      t.string :branch, null: false
      t.bigint :kind, null: false
      t.string :number, null: false
      t.bigint :company_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
