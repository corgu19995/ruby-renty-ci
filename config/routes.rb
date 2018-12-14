Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
      
  resources :cars do
    collection do
      get 'search'
    end
  end

  resources :rentals
  resources :pictures
  resources :bookings, :id => /.*/
  resources :type_vehicles
  delete 'bookings', to: 'bookings#cancelarBookings'
end
