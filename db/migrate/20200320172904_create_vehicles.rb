class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.uuid :uuid
      t.boolean :active

      t.timestamps
    end
  end
end
