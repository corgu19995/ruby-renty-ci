class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.string :user
      t.references :car, foreign_key: true
      t.datetime :bookingDate
      t.string :pickup
      t.datetime :pickupDate
      t.string :deliverPlace
      t.datetime :deliverDate
    end
  end
end
