class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.string :user
      t.references :car, foreign_key: true
      t.datetime :bookingdate
      t.string :pickup
      t.datetime :pickupdate
      t.string :deliverplace
      t.datetime :deliverdate
    end
  end
end
