class CreateTelephones < ActiveRecord::Migration[6.0]
  def change
    create_table :telephones do |t|
      t.string :number, null: false
      t.references :telephoneable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
