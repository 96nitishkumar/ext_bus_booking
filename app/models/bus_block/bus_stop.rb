module BusBlock
	class BusStop < ApplicationRecord
		self.table_name = :bus_block_bus_stops
		belongs_to :bus, class_name: "BusBlock::Bus"
		belongs_to :stop, class_name: "BusBlock::Stop"

		# validates :stop_number,uniqueness: { scope: :stop, scope: :bus },unless: :stop_number.nil?
		validate :custom_uniqueness_validation

		def custom_uniqueness_validation
		  if stop_number.present?
		    errors.add(:stop_number, 'has already been taken') if BusBlock::BusStop.where(stop_number: stop_number, bus: bus).exists?
		  end
		end

		def self.ransackable_attributes(auth_object = nil)
			["created_at", "id", "bus_id", "stop_id","updated_at", "stop_number"]
		end	

		 def self.ransackable_associations(auth_object = nil)
    	["bus", "stop"]
  	end
	end
end
