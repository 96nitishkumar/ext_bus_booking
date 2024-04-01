module BusBlock
	class Seat < ApplicationRecord
		self.table_name = :bus_block_seats

		belongs_to :bus, class_name: 'BusBlock::Bus'
		validates :seat_number, presence: true, uniqueness: { scope: :bus }
		has_many :bookings, class_name: "BookingBlock::Booking"
		validates :from_city, presence: true
		validates :to_city, presence: true

		def self.ransackable_attributes(auth_object = nil)
			["bus_id", "created_at", "from_city","id", "is_booked", "seat_number", "to_city", "updated_at"]  
		end

		validate :check_seat_capacity, on: :create

		private 

		def check_seat_capacity
			unless bus.seats.count <= bus.capacity
				errors.add(:base, "This bus seat capaity is full, so you can't add seat")
	  	end
		end

	end
end