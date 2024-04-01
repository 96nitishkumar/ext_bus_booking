class CreateBusBlockSits < ActiveRecord::Migration[7.0]
  def change
    create_table :bus_block_seats do |t|
      t.string :seat_number
      t.boolean :is_booked, default: false
      t.string :from_city
      t.string :to_city
      t.bigint :bus_id

      t.timestamps
    end
  end
end
