Rails.application.routes.draw do
  get 'closed_days/index'
  get 'closed_days/new'
  get 'closed_days/create'
  get 'closed_days/edit'
  get 'closed_days/update'
  get 'closed_days/destroy'
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  get     '/login', to: 'sessions#new'
  post    '/login', to: 'sessions#create'
  delete  '/logout', to: 'sessions#destroy'

  # 週単位のカレンダー表示用のルーティング
  get 'reservations/week/:start_date', to: 'reservations#show_week', as: 'week_calendar'

  resources :users

  # メニュー料金一覧へのルーティングを追加
  resources :menu_items

  resources :reservations

  resources :reservations do
    member do
      post 'mark_as_visited'
    end
  end
end