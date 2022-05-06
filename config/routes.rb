Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]  
    resources :book_comments, only:[:create, :destroy]
  end  
  resources :users, only: [:edit, :index, :show,  :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
