module BusBlock
	class Bus < ApplicationRecord
		self.table_name = :bus_block_buses

		has_many :seats, class_name: "BusBlock::Seat"
		has_many :bookings, class_name: "BookingBlock::Booking"
		has_many :bus_stops, class_name: "BusBlock::BusStop"
		has_many :stops, through: :bus_stops
		validates :name, presence: true
		validates :bus_number, presence: true
		validates_numericality_of :capacity, presence: true

		def self.ransackable_attributes(auth_object = nil)
			["bus_number", "capacity", "created_at", "id", "name", "updated_at"]
		end	
	end
end
