class BookingBlock::BookingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attributes :booking_details do |object|
    bus_name = BusBlock::Bus.find(object.bus_id).name
    seat_number = BusBlock::Seat.find(object.seat_id).seat_number
    from_stop = BusBlock::BusStop.find_by(bus_id: object.bus_id, stop_number: object.from_stop)
    to_stop = BusBlock::BusStop.find_by(bus_id: object.bus_id, stop_number: object.to_stop)
     data = {
          bus_name: bus_name,
          seat_number: seat_number,
          from_stop: from_stop.stop.name,
          to_stop: to_stop.stop.name
            }
  end
end
