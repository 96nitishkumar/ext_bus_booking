class CreateBusBlockBusStops < ActiveRecord::Migration[7.0]
  def change
    create_table :bus_block_bus_stops do |t|
      t.bigint :stop_id
      t.bigint :bus_id

      t.timestamps
    end
  end
end
