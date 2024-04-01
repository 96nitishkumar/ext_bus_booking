class BusBlock::BusesController < ApplicationController

	before_action :authenticate_user

	def bus_list 
		bus_list = BusBlock::Bus.all
		bus_list = bus_list.joins(:seats).where(bus_block_seats: {from_city: params[:from_city], to_city: params[:to_city]}) if params[:from_city].present? && params[:to_city].present?
		render json: { bus_list: bus_list.distinct, messages: "All buses list"}, status: 200		
	end

	def show_bus_stops
		bus = BusBlock::Bus.find(params[:bus_id])
		bus_stops = bus.stops.pluck(:stop_id)
		stop_name = BusBlock::Stop.find(bus_stops).pluck(:name)
		render json: { bus_stops: stop_name, messages: "All Stops For this bus" }, status: 200
	end

end
