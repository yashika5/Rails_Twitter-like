Rails.application.routes.draw do
    
  #get 'sessions/new'
  get 'users/new'
	root 'static_pages#home'
	get '/about', to: 'static_pages#about'
	get '/help', to: 'static_pages#help'
	get '/contact', to: 'static_pages#contact'
	get '/hello', to: 'application#hello'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/edit', to: 'account_activations#edit'

  resources :users
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
