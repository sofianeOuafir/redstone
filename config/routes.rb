Rails.application.routes.draw do
  resources :countries
  resources :users
  resources :posts
  resources :places do
    match '/scrape', to: 'vehicles#scrape', via: :post, on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
