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
    get 'available_seat', to: 'seats#available_seat'
    get 'booked_seat', to: 'seats#booked_seat'
  end

  namespace :booking_block do 
    post 'create', to: 'bookings#create'
    get 'booking_list', to: 'bookings#booking_list'
  end
end
