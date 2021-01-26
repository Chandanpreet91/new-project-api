class CreateTaxis < ActiveRecord::Migration[6.0]
  def change
    create_table :taxis do |t|
      t.string :license_plate
      t.string :make
      t.string :model
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
