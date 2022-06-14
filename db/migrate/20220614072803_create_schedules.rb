class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.date :date, null: false
      t.string :what, null: false
      t.string :do, null: false
      t.bigint :check_list, null: false, default: 0
      t.bigint :order_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
