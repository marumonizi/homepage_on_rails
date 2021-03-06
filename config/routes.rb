Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root    'static_pages#home'
  get     '/about',         to: 'static_pages#about'
  get     '/inquiry',       to: 'static_pages#inquiry'
  get     '/access',        to: 'static_pages#access'
  get     '/users/done',    to: 'users#done'
  get     '/login',         to: 'sessions#new'
  post    '/login',         to: 'sessions#create'
  delete  '/logout',        to: 'sessions#destroy'
  get     '/contacts/done', to: 'contacts#done', as: 'done'
  get     '/my_cart',       to: 'carts#index'
  post    '/add_item',      to: 'carts#add_item'
  post    '/update_item',   to: 'carts#update_item'
  delete  '/delete_item',   to: 'carts#delete_item'
  get     '/acount_activation/resend', to: 'acount_activations#resend'
  resources :users, :microposts, :contacts, :products
  resources :acount_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end