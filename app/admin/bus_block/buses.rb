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
        bus = BusBlock::Bus.new(resource_params.first)
        
        if bus.save
          stop_ids.shift
          stops = BusBlock::Stop.find(stop_ids)
          bus.stops << stops
          redirect_to admin_bus_path(bus.id)
        else
          flash[:error] = bus.errors.full_messages.join(", ")
          raise ActiveRecord::Rollback
        end
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

  # panel "Followings" do
  #   table_for(user.followings) do
  #     if user.followings.present?
  #       column :following_username do |fg_user|
  #         link_to fg_user.following.name.capitalize, admin_user_path(fg_user.following_id)
  #       end
  #       column :follower_profile_pic do |user|
  #         user.following.profile_pic.attached? ? image_tag(url_for(user.following.profile_pic),style: 'border-radius: 50%; height: 50px; width: 50px;'):"profile pic not found"
  #       end
  #     else
  #       para "No followings found."
  #     end
  #   end
  # end

  # panel "Favorite Property" do
  #   table_for(user.favorite_properties) do
  #     if user.favorite_properties.present?
  #       column :property_name do |p_name|
  #         link_to p_name.property.property_name, admin_property_path(p_name.property.id)
  #       end
  #       column :average_rating do |p_name|
  #         p_name.property.ratings.average(:value)||0.0
  #       end
  #     else
  #       para "No property found."
  #     end
  #   end
  # end

  # panel "Property Rated List" do
  #   table_for(user.ratings) do
  #     if user.ratings.present?
  #       column :property_name do |rating|
  #         link_to rating.property.property_name, admin_property_path(rating.property_id)
  #       end
  #       column :rating_value do |rating|
  #         rating.value
  #       end
  #     else
  #       para "No property Rated found."
  #     end
  #   end
  end
end
