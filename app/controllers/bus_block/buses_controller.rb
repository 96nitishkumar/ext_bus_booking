class BusBlock::BusesController < ApplicationController

	before_action :authenticate_user

	def show_bus_stops
		bus = BusBlock::Bus.find(params[:bus_id])
		stop_ids = BusBlock::BusStop.where(bus_id: bus.id).order(stop_number: :asc).pluck(:stop_id)
		bus_stops = BusBlock::Stop.find(stop_ids)
		render json: { bus_stops: bus_stops, messages: "All Stops For this bus" }, status: 200
	end

	def bus_list
		from_city = BusBlock::Stop.find_by(name: (params[:from_city])&.downcase&.strip)
		to_city = BusBlock::Stop.find_by(name: (params[:to_city])&.downcase&.strip)
		if from_city.present? & to_city.present? & (from_city != to_city)
			bus_count = BusBlock::BusStop.where("stop_id=? or stop_id=?",from_city.id, to_city.id).group(:bus_id).count
			bus_id = bus_count.select{|k,v| v == 2}.keys
			buses = BusBlock::Bus.find(bus_id)
			render json: {bus_list: buses}
		else
			render json: { errors: "No Bus Found for this location"}, status: 422
		end
	end

end
