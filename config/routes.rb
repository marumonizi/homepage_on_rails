Rails.application.routes.draw do
  root    'static_pages#home'
  get     '/about',   to: 'static_pages#about'
  get     '/inquiry', to: 'static_pages#inquiry'
  get     '/access',  to: 'static_pages#access'
  get     '/signup',  to: 'users#new'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  get     '/contacts/done', to: 'contacts#done', as: 'done'
  resources :users, :microposts, :contacts
end
