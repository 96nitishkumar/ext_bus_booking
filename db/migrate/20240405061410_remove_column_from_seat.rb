class RemoveColumnFromSeat < ActiveRecord::Migration[7.0]
  def change
    remove_column :bus_block_seats, :from_city
    remove_column :bus_block_seats, :to_city
  end
end
