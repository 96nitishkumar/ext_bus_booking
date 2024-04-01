FactoryBot.define do
  factory :booking_block_booking, class: 'BookingBlock::Booking' do
    seat_id { "" }
    bus_id { "" }
    user_id { "" }
  end
end
