class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :content
      t.bigint :company_id, null: false, index: true, foreign_key: true
      t.bigint :category_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
