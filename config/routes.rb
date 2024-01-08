Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  get     '/login', to: 'sessions#new'
  post    '/login', to: 'sessions#create'
  delete  '/logout', to: 'sessions#destroy'

  resources :users

  # メニュー項目の一覧表
  get '/menu_items', to: 'menu_items#index'

  # メニュー項目の詳細表示
  get '/menu_items/:id', to: 'menu_items#show', as: 'menu_item'

  # 新しいメニュー項目の作成フォーム
  get '/menu_items/new', to: 'menu_items#new', as: 'new_menu_item'

  # メニュー項目の作成
  post '/menu_items', to: 'menu_items#create'

  # メニュー項目の編集フォーム
  get '/menu_items/:id/edit', to: 'menu_items#edit', as: 'edit_menu_item'

  # メニュー項目の更新
  patch '/menu_items/:id', to: 'menu_items#update'

  # メニュー項目の削除
  delete '/menu_items/:id', to: 'menu_items#destroy'
end