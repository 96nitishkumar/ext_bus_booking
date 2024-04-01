ActiveAdmin.register BusBlock::BusStop, as: "BusStop" do
  permit_params :stop_id, :bus_id, :stop_number
  index do
    selectable_column
    id_column
    column :buses do |bus_stop|
      bus_stop.bus.name
    end
    column :stops do |stop|
      stop.stop.name
    end
    column :stop_number
    column :created_at
    actions
  end

end
