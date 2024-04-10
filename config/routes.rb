Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  namespace :user_block do 
    post 'sign_up', to: 'users#sign_up'
    post 'sign_in', to: 'users#sign_in'
  end

  namespace :bus_block do 
    get 'bus_list', to: 'buses#bus_list'
    get 'show_bus_stops', to: 'buses#show_bus_stops'
    get 'available_or_booked_seat', to: 'seats#available_or_booked_seat'
    get 'location_based_stops', to: 'buses#location_based_stops'
  end

  namespace :booking_block do 
    post 'create', to: 'bookings#create'
    get 'booking_list', to: 'bookings#booking_list'
    get 'download_file', to: 'bookings#download_file'
  end
end
