Rails.application.routes.draw do
  match '*path' => 'options_request#preflight', via: :options
  #認証
  resources :auth, :only => [:create, :destroy]

  namespace :api do
    namespace :v1 do

      #ユーザー
      get '/users',        to: 'users#index'
      get '/users-show',   to: 'users#show'
      post '/user-create', to: 'users#create'
      post '/user-update', to: 'users#update'

      #スタッフ
      get '/staff',         to: 'staffs#index'
      get '/staffs',        to: 'staffs#staffs_data'
      post '/staff-create', to: 'staffs#create'
      post '/staff-update', to: "staffs#update"
      post '/staff-delete', to: "staffs#delete"

      #コース
      get '/cource', to: 'cources#index'

      #予約
      post '/reservation-create', to: 'reservations#create'
      post '/reservation-search', to: 'reservations#search'
      get '/reservation-today',   to: 'reservations#show'
      get '/reservation-all',     to: 'reservations#all_data'
    end
  end
end
