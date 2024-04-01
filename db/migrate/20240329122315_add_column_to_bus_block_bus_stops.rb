class AddColumnToBusBlockBusStops < ActiveRecord::Migration[7.0]
  def change
    add_column :bus_block_bus_stops, :stop_number, :integer
  end
end
