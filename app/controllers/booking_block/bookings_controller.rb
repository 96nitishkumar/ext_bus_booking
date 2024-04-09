class BookingBlock::BookingsController < ApplicationController
require 'net/sftp'
	before_action :authenticate_user
	before_action :check_booking, only: [:create]

	def create
		booking = @current_user.bookings.build(bus_id: @bus.id, seat_id: @seat.id, from_stop: @from_stop.stop_number, to_stop: @to_stop.stop_number)
		if booking.save
			render json: { booking_data: BookingBlock::BookingSerializer.new(booking).serializable_hash, messages: "You booked seat sucessfully" }, staus: 200
		else
			render json: { errors: booking.errors.full_messages, messages: "Your booking failed"}, status: 422
		end
	end

	def booking_list
		render json: {bookings: BookingBlock::BookingSerializer.new(@current_user.bookings).serializable_hash, messages: "You booking list"}, status: 200
	end

	private 

	def check_booking 
		@bus = BusBlock::Bus.find(params[:bus_id])
		@seat = @bus.seats.find_by(id: params[:seat_id])
		@from_stop = BusBlock::BusStop.find_by(bus_id: @bus.id, stop_id: params[:from_stop_id])
		@to_stop = BusBlock::BusStop.find_by(bus_id: @bus.id, stop_id: params[:to_stop_id])

		if @from_stop && @to_stop
			
			return render json: { errors: "Invalid bus stops, Please check" } if @from_stop.stop_number >= @to_stop.stop_number
		else
			return render json: { errors: "Please send the bus correct stop id"}
		end
	end


end
