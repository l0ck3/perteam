Rails.application.routes.draw do

  resources :events, except: [:edit, :update] do
    post '/create-teams', to: 'teams#generate_teams'
  end

  resources :teams, only: [:index]
  resources :users, only: [:new, :create]

  root to: 'teams#index'
end
