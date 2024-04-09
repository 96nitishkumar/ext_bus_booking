class BookingBlock::Booking < ApplicationRecord

	self.table_name = :booking_block_bookings

	belongs_to :user, class_name: "UserBlock::User"
	belongs_to :bus, class_name: "BusBlock::Bus"
	belongs_to :seat, class_name: "BusBlock::Seat"
	validate :check_booked_seat, on: :create
	before_save :set_amount

	enum status: ["pending", "confirmed", "rejected", "expired"]

	def check_booked_seat
	  bookings = bus.bookings.where(seat_id: seat.id)
	  return unless bookings.present?

	  booked_stops = bookings.pluck(:from_stop, :to_stop)
	  if booked_stops.any? { |stop| (stop[0]...stop[-1]).cover?(from_stop) || (stop[-1]...stop[0]).cover?(to_stop) }
	    errors.add(:base, "This seat is not available for this location")
	  end
	end

	def set_amount
		lat_and_lng = BusBlock::Stop.find([from_stop, to_stop]).pluck(:latitude,:longitude)
		distance_in_miles = Geocoder::Calculations.distance_between(lat_and_lng[0], lat_and_lng[-1])
		distance_in_km = distance_in_miles * 1.60934
		self.amount  = distance_in_km * 3
	end


end
