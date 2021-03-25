Rails.application.routes.draw do
  root 'listings#index'
  resources :listings, only: %i[index new create destroy show]
  post '/listings/synch_with_pb', to: 'listings#synch_with_pb'
  post '/listings/purge_old_listings', to: 'listings#purge_old_listings'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
