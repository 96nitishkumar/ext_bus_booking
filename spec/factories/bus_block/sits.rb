FactoryBot.define do
  factory :bus_block_sit, class: 'BusBlock::Sit' do
    seat_number { "MyString" }
    is_booked { false }
    from_city { "MyString" }
    string { "MyString" }
    to_city { "MyString" }
    bus_id { "" }
  end
end
