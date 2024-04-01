class BookingBlock::BookingsController < ApplicationController

	before_action :authenticate_user
	before_action :check_booking, only: [:create]

	def create 
		booking = @current_user.bookings.build(bus_id: @bus.id, seat_id: @seat.id)
		if booking.save
			render json: { booking_data: booking, messages: "You booked seat sucessfully" }, staus: 200
		else
			render json: { errors: booking.errors.full_messages, messages: "Your booking failed"}, status: 422
		end
	end

	def booking_list
		render json: {bookings: @current_user.bookings, messages: "You booking list"}, status: 200
	end

	private 

	def check_booking 
		@bus = BusBlock::Bus.find(params[:bus_id])
		@seat = @bus.seats.find_by(id: params[:seat_id])
		return render json: { errors: "This seat is already booked" } if @seat.is_booked
	end


end
