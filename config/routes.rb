Basestar::Application.routes.draw do
  get "ais/public" => "ais#public"
  resources :ais

  devise_for :users

  get "hi" => "hi#index"
  get "hi/secret"

  root :to => "hi#index"
end
