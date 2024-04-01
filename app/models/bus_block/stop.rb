module BusBlock

	class Stop < ApplicationRecord
		self.table_name = :bus_block_stops
		has_many :bus_stops, class_name: "BusBlock::BusStop"
		has_many :buses, through: :bus_stops
		validates :name, presence: true, uniqueness: true
		validates :city, presence: true

		def self.ransackable_attributes(auth_object = nil)
    	["city", "created_at", "id", "name", "updated_at"]
 		end

 		def self.ransackable_associations(auth_object = nil)
    	["bus_stops", "buses"]
  	end

	end
end
