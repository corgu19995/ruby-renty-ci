class CreateTypeVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :type_vehicles do |t|
      t.string :name
    end
  end
end
