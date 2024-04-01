class BookingBlock::Booking < ApplicationRecord

	self.table_name = :booking_block_bookings

	belongs_to :user, class_name: "UserBlock::User"
	belongs_to :bus, class_name: "BusBlock::Bus"
	belongs_to :seat, class_name: "BusBlock::Seat"

	after_create :update_seat

	def update_seat
		seat.update(is_booked: true)
	end
end
