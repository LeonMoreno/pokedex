Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/health', to: 'health#health'

  # By convention --   resources :pokemon

  get '/pokemon', to: 'pokemon#index'
  get '/pokemon/:id', to: 'pokemon#show'
  post '/pokemon', to: 'pokemon#create'
  put '/pokemon/:id', to: 'pokemon#update'

end