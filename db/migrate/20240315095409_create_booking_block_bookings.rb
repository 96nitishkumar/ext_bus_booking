class CreateBookingBlockBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_block_bookings do |t|
      t.bigint :seat_id
      t.bigint :bus_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
