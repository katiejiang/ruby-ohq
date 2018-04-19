Rails.application.routes.draw do
  root 'application#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :courses do
    resources :questions do
      post '/help', to: 'questions#help'
      post '/resolve', to: 'questions#resolve'
    end
  end
  resources :users, except: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlc
end
