class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, unique: true
      t.bigint :company_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
