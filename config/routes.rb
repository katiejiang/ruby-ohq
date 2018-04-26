Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :courses do
    post '/enroll', to: 'courses#enroll'
    delete '/unenroll', to: 'courses#unenroll'
    post '/invite', to: 'courses#invite'
    post '/change-admin', to: 'courses#change_admin'
    post '/change-staff', to: 'courses#change_staff'
    delete '/remove-staff', to: 'courses#remove_staff'
    resources :questions do
      post '/help', to: 'questions#help'
      post '/resolve', to: 'questions#resolve'
    end
  end
  resources :users, except: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlc
end
