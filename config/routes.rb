Rails.application.routes.draw do
  resources :about, only: [:index]

  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post   :add_item
    post   :remove_item
  end

  resources :orders, only: [:create, :show]

  namespace :admin do
    root to: 'dashboard#show'
    resources :products, except: [:edit, :update, :show]
    resources :categories, only: [:index, :new, :create]
  end
  

     # These routes will be for signup. The first renders a form in the browse, the second will 
    # receive the form and create a user in our database using the data given to us by the user.
    get '/login' => 'session#new'
    post '/login' => 'session#create'
    get '/logout' => 'session#destroy'
  
    get '/signup' => 'user#new'
    post '/users' => 'user#create'

end

