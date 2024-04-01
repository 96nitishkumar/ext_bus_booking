class BusBlock::SeatsController < ApplicationController

	before_action :authenticate_user
	before_action :set_bus

	def available_seat
		available_seat = @bus.seats.where(is_booked: false)
		available_seat_count =  available_seat.count
		data = {}
		data[:available_seat] = available_seat
		data[:available_seat_count] = available_seat_count

		render json: { seat_data: data, messages: "Available_seat"}, status: 200
	end

	def booked_seat
		booked_seat_list = @bus.seats.where(is_booked: true)
		booked_seat_count =  booked_seat_list.count
		data = {}
		data[:booked_seat_list] = booked_seat_list
		data[:booked_seat_count] = booked_seat_count

		render json: { seat_data: data, messages: "Booked_seat_list"}, status: 200

	end

	private 

	def set_bus
		@bus = BusBlock::Bus.find(params[:bus_id])
	end


end
