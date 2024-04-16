ActiveAdmin.register PolicyBlock::PrivacyPolocy, as: "PrivacyPolocy" do
  permit_params :title, :description, images: []

  index do
    selectable_column
    id_column
    column :title
    column :description
     column :images do |policy|
        if policy.images.attached?
          policy.images.map{|img| image_tag(url_for(img), style: 'width:50px; height: 50px;border-radius: 50%;')}
        else
          "images are not attached"
        end
    end
    column :created_at
    actions
  end

  filter :title
  filter :description
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :images, as: :file, input_html: { multiple: true }
    end      
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :images do |policy|
        if policy.images.attached?
          policy.images.map{|img| image_tag(url_for(img), style: 'width:50px; height: 50px;border-radius: 50%;')}
        else
          "images are not attached"
        end
      end
    end
  end



end
