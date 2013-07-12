class CreateVehicleLogs < ActiveRecord::Migration
  def change
    create_table :vehicle_logs do |t|
      t.string :plate
      t.string :timestamp

      t.timestamps
    end
  end
end
