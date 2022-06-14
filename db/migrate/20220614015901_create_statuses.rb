class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.bigint :status, null: false, default: 0
      t.bigint :order_supply_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
