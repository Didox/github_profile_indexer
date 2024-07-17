Rails.application.routes.draw do
  root 'home#index'

  resources :profiles do
    member do
      post 'rescan'
    end

    collection do
      get 'search'
    end
  end

  get 'change_language/:locale', to: 'application#change_language', as: :change_language
end
