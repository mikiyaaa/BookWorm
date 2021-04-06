Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources 'books', only: [:index, :new, :create, :destroy] do
    resources 'reviews', only: [:index, :new, :create, :edit, :update ]
  end
end