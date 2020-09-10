Rails.application.routes.draw do
  root 'listings#index'
  resources :listings
  post '/listings/synch_with_pb', to: 'listings#synch_with_pb'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
