Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount GoodJob::Engine => "jobs"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  devise_for :users, path: "account", path_names: {
    sign_up: "signup",
    sign_in: "login",
    sign_out: "logout"
  }

  root "pages#home"
end
