class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :thumbnail
      t.string :price
      t.string :model
      t.integer :rental
      t.string :plate
      t.integer :rating
      t.integer :capacity
      t.string :transmission
      t.integer :doors
      t.string :color
      t.integer :kms
      t.references :rental, foreign_key: true
      t.references :type_vehicle, foreign_key: true
    end
  end
end
