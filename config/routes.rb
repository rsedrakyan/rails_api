Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  namespace :v1, defaults: { format: :json } do
    resources :users, only: [:index, :show, :create, :update, :destroy] do
      resources :playlists, only: [:index, :show, :create, :update, :destroy]
      resources :subscriptions, only: [:index, :show, :create, :destroy]
    end

    resources :playlists, only: [] do
      resources :tracks, only: [:index, :show, :create, :update, :destroy]
    end
  end

end
