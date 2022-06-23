Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'products#index'
  get 'things/show', to: 'things#show'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create, :show, :edit, :update]
  resources :companies
  resources :products
  resources :categories
  resources :deliveries
  resources :payees

  resources :invoices do
    collection do
      get :index_receive
    end
  end

  resources :orders do
    collection do
      get :index_receive
      get :index_supply
      get :index_receive_month
      get :index_receive_delivery
      post :confirm
      post :back
      get :ajax
    end
  end

  resources :supplies do

    collection do
      get :ajax
    end
  end

  resources :statuses do
    member do
      post :update_1
      post :update_3
      post :update_6
    end
  end

  resources :schedules do
    member do
      post :update_check
      post :update_noncheck
      post :update_check_task
      post :update_noncheck_task
    end
    collection do
      get :index_day
    end
  end

  resources :approvals do
    member do
      post :update_invoice
      post :update_order
    end
  end

  resources :cancels do
    member do
      post :update_noncancel
      post :update_cancel
    end
  end
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
