class CreateBusBlockBuses < ActiveRecord::Migration[7.0]
  def change
    create_table :bus_block_buses do |t|
      t.string :name
      t.string :bus_number
      t.integer :capacity

      t.timestamps
    end
  end
end
