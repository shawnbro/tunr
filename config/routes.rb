Tunr::Application.routes.draw do
  resources :artists do
    resources :songs, except: [:index, :show], shallow: true do
      resources :purchases, only: [:create]
    end
  end

  resources :users do
    resources :songs, only: [:index]
    resources :playlists, only: [:new, :create, :show, :edit], shallow: true
    resources :shared_playlists, only: [:new, :create, :show], shallow: true
  end

  



  #resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "session#new"
  post "/session", to: "session#create"
  delete "/session", to: "session#destroy"

  root "welcome#index"
end