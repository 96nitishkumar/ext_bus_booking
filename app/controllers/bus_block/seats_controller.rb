class BusBlock::SeatsController < ApplicationController

	before_action :authenticate_user
	before_action :set_bus

	
	def available_or_booked_seat

		from_stop_number = @bus.bus_stops.find_by(stop_id: params[:from_stop_id])&.stop_number
		to_stop_number = @bus.bus_stops.find_by(stop_id: params[:to_stop_id])&.stop_number
		bookings = @bus.bookings
		seats = @bus.seats
		available_seat_ids = seats.ids
		booked_seat_ids = []
		if bookings.present? & from_stop_number & to_stop_number
			available_seat_ids = seats.ids - bookings.pluck(:seat_id)
				
			bookings.each do |booking|

				booked_stops = bookings.where(seat_id: booking.seat_id).pluck(:from_stop, :to_stop)
				if booked_stops.any? { |stop| (stop[0]...stop[-1]).cover?(from_stop_number) || (stop[-1]...stop[0]).cover?(to_stop_number) }
		    	booked_seat_ids.push(booking.seat_id)
		    else
		    	available_seat_ids.push(booking.seat_id)
		  	end
			end

		end
		booked_seat_ids = booked_seat_ids.uniq.sort
		available_seat_ids = available_seat_ids.uniq.sort

		data = {}
		data[:available_seat] = BusBlock::Seat.find(available_seat_ids)
		data[:booked_seat] = BusBlock::Seat.find(booked_seat_ids)
		data[:available_seat_count] = available_seat_ids.count
		data[:booked_seat_count] = booked_seat_ids.count

		render json: { seat_data: data, messages: "Available or Booked seat"}, status: 200
	end

	private
	def set_bus
		@bus = BusBlock::Bus.find(params[:bus_id])
	end


end
