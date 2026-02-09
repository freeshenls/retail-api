Rails.application.routes.draw do
  get '/assets/_/:filename', to: redirect { |params, request| "/_/#{params[:filename]}" }
  
  devise_for :users, class_name: "Sys::User", controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  authenticated :user do
    get "profile", to: "base#profile", as: :profile
    patch "profile", to: "base#profile_update"
  end

  authenticated :user, ->(u) { u.role.name == "admin" } do
    root to: redirect("/admin/users"), as: :admin_root

    namespace :admin do
      resources :users
      resources :roles, only: [:index]
      resources :invites, only: [:index, :create]

      resources :customers

      resources :orders, only: [:index, :edit, :update, :show] do
        collection do
          get :unsettled
          get :settled
        end
      end

      resources :categories
      resources :service_types
    end
  end

  authenticated :user, ->(u) { u.role.name == "staff" } do
    root to: redirect("/staff/orders/submitted"), as: :staff_root

    namespace :staff do
      # 移除了 :index
      resources :orders, only: [:show] do
        collection do
          get :submitted
          get :approved
          get :rejected
        end
        member do
          patch :accept
          patch :approve
          patch :reject
        end
      end
    end
  end
  
  authenticated :user, ->(u) { u.role.name == "designer" } do
    root to: redirect("/designer/orders/new"), as: :designer_root

    namespace :designer do
      # 移除了 :index
      resources :orders, only: [:new, :create, :edit, :update, :show, :destroy] do
        collection do
          get :pending
          get :completed
        end
      end
    end
  end

  authenticated :user, ->(u) { u.role.name == "finance" } do
    root to: redirect("/finance/orders/unsettled"), as: :finance_root

    namespace :finance do
      resources :orders, only: [:index, :show] do
        collection do
          get :unsettled
          get :settled
        end
      end
    end
  end

  namespace :layout do
    get "tabs/refresh"
  end

  # Defines the root path route ("/")
  devise_scope :user do
    root to: "users/sessions#new"
  end
end
