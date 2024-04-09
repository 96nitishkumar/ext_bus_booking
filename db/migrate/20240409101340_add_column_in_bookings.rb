class AddColumnInBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :booking_block_bookings, :status, :integer, default:0
    add_column :booking_block_bookings, :amount, :float, default:0
  end
end
