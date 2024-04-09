ActiveAdmin.register BusBlock::Bus, as: "Bus" do
  permit_params :name, :bus_number, :capacity, stop_ids:[]

  index do
    selectable_column
    id_column
    column :buses do |bus|
      bus.name
    end
    column :bus_number
    column :capacity
    column :created_at
    actions
  end

  controller do 
    def create
      ActiveRecord::Base.transaction do
        stop_ids = params["bus_block_bus"]["stop_ids"]
        params["bus_block_bus"].delete("stop_ids")
        @bus = BusBlock::Bus.new(resource_params.first)
        
        if @bus.save
          stop_ids.shift
          stops = BusBlock::Stop.find(stop_ids)
          @bus.stops << stops
          redirect_to admin_bus_path(@bus.id)
        else
          render :new
          raise ActiveRecord::Rollback
        end
      end
      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = e.message
        redirect_to :new_admin_bus
    end


    def update
        stop_ids = params["bus_block_bus"]["stop_ids"]
        params["bus_block_bus"].delete("stop_ids")
        @bus = BusBlock::Bus.find(params[:id])
        stop_ids.shift
        stops = BusBlock::Stop.find(stop_ids)
        exists_stop_ids = @bus.stops.ids & stops.pluck(:id)
        if exists_stop_ids.present?
          flash[:errors] = "This Bus already has #{BusBlock::Stop.find(exists_stop_ids).pluck(:name).join(", ")} please choose another bus stops"
        elsif @bus.update(resource_params.first)
          @bus.stops << stops
          redirect_to admin_bus_path(@bus.id)
        else
          render :new
        end

    rescue ActiveRecord::RecordInvalid => e
        flash[:error] = e.message
        redirect_to :new_admin_bus
    end
  end


  filter :name
  filter :bus_number
  filter :sign_in_count
  filter :capacity

  form do |f|
    f.inputs do
      f.input :name
      f.input :bus_number
      f.input :capacity
      f.input :stops, as: :check_boxes
    end
    f.actions
  end


  show do
  attributes_table do
    row :name
    row :bus_number
    row :capacity
  end

  panel "Seat details" do
    table_for(bus.seats) do
      if bus.seats.present?
        column :seat_number do |seat|
          seat.seat_number.capitalize
        end
      else
        para "No seat found."
      end
    end
  end

  panel "Stops" do
    table_for(stops = bus.bus_stops.order(stop_number: :asc)) do
      if stops.present?
        column :bus_stops_name do |stop|
          link_to stop.stop.name.capitalize, admin_stop_path(stop.stop.id)
        end
        column :bus_stops_number do |stop|
            stop.stop_number || "Not found"
        end
      else
        para "No stops found."
      end
    end
  end
  end
end
