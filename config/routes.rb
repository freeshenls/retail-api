Rails.application.routes.draw do
  namespace :designer do
    get "orders/index"
  end
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

  authenticated :user, ->(u) { u.role.name == "admin" } do
    get "admin", to: "admin#index", as: :admin
    root to: redirect("/admin"), as: :admin_root
    namespace :admin do
      resources :users, only: [:index, :destroy, :edit, :update]
      resources :roles, only: [:index]
      resources :invites, only: [:index, :create]
    end
  end

  authenticated :user, ->(u) { u.role.name == "staff" } do
    get "staff", to: "staff#index", as: :staff
    root to: redirect("/staff"), as: :staff_root
    namespace :staff do
      resources :orders, only: [:index, :new, :create, :show]
    end
  end
  
  authenticated :user, ->(u) { u.role.name == "designer" } do
    get "designer", to: "designer#index", as: :designer
    root to: redirect("/designer"), as: :designer_root

    namespace :designer do
      resources :drafts, only: [:index, :new, :create, :show]
      
      # 移除了 :index
      resources :orders, only: [:edit, :update, :show, :destroy] do
        collection do
          get :pending
          get :completed
        end
      end
    end
  end

  authenticated :user, ->(u) { u.role.name == "finance" } do
    get "finance", to: "finance#index", as: :finance
    root to: redirect("/finance"), as: :finance_root
    namespace :finance do
      resources :drafts, only: [:index, :new, :create]
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
