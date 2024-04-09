ActiveAdmin.register BusBlock::Seat, as: "Seat" do
  permit_params :seat_number, :bus_id

  index do
    selectable_column
    id_column
    column :buses do |seat|
      seat.bus.name
    end   
    column :seat_number
    column :created_at
    actions
  end

  controller do
    def create
      @resource = resource_class.new(resource_params.first)

      if @resource.save
        redirect_to admin_seat_path(@resource.id), notice: "Seat was successfully created."
      else
        render :new
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

  form do |f|
    f.inputs do
      f.input :bus, as: :select, collection: BusBlock::Bus.all.map { |b| [b.name, b.id] },prompt: "select bus"
      f.input :seat_number
      f.object.errors.full_messages.each do |msg|
        f.semantic_errors msg
      end
    end
    f.actions
  end

end
