class CreateBusBlockStops < ActiveRecord::Migration[7.0]
  def change
    create_table :bus_block_stops do |t|
      t.string :name
      t.string :city

      t.timestamps
    end
  end
end
