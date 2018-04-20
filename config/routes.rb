Rails.application.routes.draw do
  root 'application#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :courses do
    resources :questions do
    end
  end
  resources :users, except: [:index]

  # COURSES
  post '/courses/:id/enroll', to: 'courses#enroll'
  delete '/courses/:id/unenroll', to: 'courses#unenroll'

  # QUESTIONS
  post 'courses/:id/help', to: 'questions#help'
  post 'courses/:id/resolve', to: 'questions#resolve'

  # USER

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlc
end
