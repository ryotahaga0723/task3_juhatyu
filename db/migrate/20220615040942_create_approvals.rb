class CreateApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :approvals do |t|
      t.bigint :approval, null: false, default: 0
      t.bigint :user_id, null: false, index: true, foreign_key: true
      t.references :approvalable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
