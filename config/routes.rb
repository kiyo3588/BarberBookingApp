Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  get     '/login', to: 'sessions#new'
  post    '/login', to: 'sessions#create'
  delete  '/logout', to: 'sessions#destroy'

  resources :users

  # メニュー料金一覧へのルーティングを追加
  resources :menu_items, only: [:index]
end