Rails.application.routes.draw do
  resources :blogs do
    resources :comments, only: %w[create destroy]
    post :favorite
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: %w[index show] do
    post :follow
  end
end
