Rails.application.routes.draw do
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
    collection do
      post :create_visit_history
    end
  end
end