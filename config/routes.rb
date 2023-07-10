Rails.application.routes.draw do
  # get 'pokemon/index'
  # get 'pokemon/show'
  # get 'pokemon/create'
  # get 'pokemon/update'
  # get 'health/health'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/health', to: 'health#health'
  get '/pokemon', to: 'pokemon#index'
  # get '/pokemon', to: 'pokemon#index', as: 'pokemon_index'

  get '/pokemon/:id', to: 'pokemon#show'
  post '/pokemon', to: 'pokemon#create'
  put '/pokemon/:id', to: 'pokemon#update'
  # get '/type/:id', to: 'type_poke#index'

end
