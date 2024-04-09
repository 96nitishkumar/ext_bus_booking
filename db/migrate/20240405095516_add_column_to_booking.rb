class AddColumnToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :booking_block_bookings, :from_stop, :integer
    add_column :booking_block_bookings, :to_stop, :integer
  end
end
