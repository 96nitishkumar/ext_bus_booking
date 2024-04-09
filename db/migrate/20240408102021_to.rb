class To < ActiveRecord::Migration[7.0]
  def change
    add_column :bus_block_stops, :latitude, :float
    add_column :bus_block_stops, :longitude, :float
    add_column :bus_block_stops, :address, :string
  end
end
