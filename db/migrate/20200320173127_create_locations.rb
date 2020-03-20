class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lng
      t.datetime :at
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
