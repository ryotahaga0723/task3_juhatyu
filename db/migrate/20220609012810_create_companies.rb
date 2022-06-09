class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies, id: false do |t|
      t.bigint :code, null: false, primary_key: true, unique: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
