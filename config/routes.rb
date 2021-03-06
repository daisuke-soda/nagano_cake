Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }
  scope module: :public do
    root to: 'homes#top'
    get '/customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit, :update]
    put "/customers/:id/leave" => "customers#leave", as: 'customer_leave'
    resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete '/cart_items' => 'cart_items#destroy_all', as:'cart_item_destroy_all'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    resources :orders, only: [:index, :show, :new, :create] do
      resource :order_item, only: [:create]
    end
  end

  namespace :admin do
    root to: 'homes#top'
    get '/search' => 'search#search'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    get '/customers/:id/orders' => 'orders#customers_order'
    get '/todays_order' => 'orders#todays_order'
    resources :orders, only: [:index, :show, :update] do
      resources :order_items, only: [:update]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
