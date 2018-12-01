Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
      
  resources :users 
  resources :cars do
    collection do
      get 'search'
    end
  end

  resources :rentals
  resources :pictures
end
