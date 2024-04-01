ActiveAdmin.register BusBlock::Stop, as: "Stop" do
  permit_params :name, :city
  index do
    selectable_column
    id_column
    column :name
    column :city
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      
      f.input :name
      f.input :city
    end
    f.actions
  end

end
