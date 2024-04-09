class RemoveColumnToSeat < ActiveRecord::Migration[7.0]
  def change
    remove_column :bus_block_seats, :is_booked
  end
end
