module BusBlock

	class Stop < ApplicationRecord
		self.table_name = :bus_block_stops
		has_many :bus_stops, class_name: "BusBlock::BusStop", dependent: :destroy
		has_many :buses, through: :bus_stops, dependent: :destroy
		validates :name, presence: true, uniqueness: true
		validates :city, presence: true
		before_validation :set_address
		geocoded_by :address
		after_validation :geocode

		def self.ransackable_attributes(auth_object = nil)
    	["city", "created_at", "id", "name", "updated_at", "latitude", "longitude", "address"]
 		end

 		def self.ransackable_associations(auth_object = nil)
    		["bus_stops", "buses"]
    	end

    	def set_address
    		self.address = [name,city].join(", ")
    	end

	end
end
