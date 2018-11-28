class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :car, foreign_key: true
      t.datetime :from
      t.datetime :to
    end
  end
end
