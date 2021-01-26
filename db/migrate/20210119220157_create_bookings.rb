class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :taxi, null: false, foreign_key: true
      t.text :pickup_location
      t.text :dropoff_location
      t.integer :tip
      t.integer :rating
      t.string :status
      t.datetime :booked_time
      t.datetime :pickup_time
      t.datetime :dropoff_time

      t.timestamps
    end
  end
end
