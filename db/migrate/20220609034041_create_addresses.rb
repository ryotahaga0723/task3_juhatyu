class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.bigint :postcode, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :town, null: false
      t.string :address, null: false
      t.string :building
      t.string :room_number
      t.references :addressable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
