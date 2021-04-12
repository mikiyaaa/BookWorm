Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root 'books#index'
  resources 'books', only: [:index, :new, :create, :destroy] do
    resources 'reviews', only: [:index, :new, :create, :edit, :update ]
  end
end