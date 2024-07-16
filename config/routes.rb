Rails.application.routes.draw do
  root 'home#index'
  get '/s/:unique_key', to: 'shortened_urls#show', as: :short
  resources :profiles do
    member do
      post 'rescan'
    end
  end
end
