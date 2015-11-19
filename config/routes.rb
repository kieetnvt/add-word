Rails.application.routes.draw do
  root 'home#index'

  resources :words do
    collection do
      get "search"
    end
  end

  get "/translate/history", to: "translates#history", as: "translated"
  get "/translate", to: "translates#translate", as: "translate"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :admin do
    root 'words#index'
    
    resources :words
    resources :users
  end

end
