Rails.application.routes.draw do
  root to: "welcome#index"
  devise_for :users
  resources :users do
    resources :entry_logs, controller: "users/entry_logs"
  end
end
