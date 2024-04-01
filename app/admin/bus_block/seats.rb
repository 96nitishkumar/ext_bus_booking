ActiveAdmin.register BusBlock::Seat, as: "Seat" do
  permit_params :seat_number, :is_booked, :from_city, :to_city, :bus_id

  index do
    selectable_column
    id_column
    column :buses do |seat|
      seat.bus.name
    end   
    column :seat_number
    column :is_booked
    column :from_city
    column :to_city
    actions
  end

  controller do
    def create
      resource = resource_class.new(resource_params.first)
      if resource.save
        redirect_to admin_seat_path(resource.id), notice: "Seat was successfully created."
      else
        flash[:error] = "Seat create failed: #{resource.errors.full_messages.join(', ')}"
        redirect_to new_admin_seat_path
      end
    end

    def update
       resource = BusBlock::Seat.find(params[:id])
      if resource.update(resource_params.first)
        redirect_to admin_seat_path(resource.id), notice: "Seat is successfully updated."
      else
        flash[:error] = "Seat update failed: #{resource.errors.full_messages.join(', ')}"
        render :edit
      end
    end
  end


  filter :seat_number
  filter :is_booked
  filter :from_city
  filter :capacity

  form do |f|
    f.inputs do
      f.input :bus, as: :select, collection: BusBlock::Bus.all.map { |b| [b.name, b.id] }
      f.input :seat_number
      f.input :from_city
      f.input :to_city
      f.object.errors.full_messages.each do |msg|
        f.semantic_errors msg
      end
    end
    f.actions
  end

end
