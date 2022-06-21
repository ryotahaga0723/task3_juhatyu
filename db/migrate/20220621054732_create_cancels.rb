class CreateCancels < ActiveRecord::Migration[6.0]
  def change
    create_table :cancels do |t|
      t.boolean :cancel, null:false, default: false
      t.bigint :supply_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
