Basestar::Application.routes.draw do
  devise_for :users

  get "hi" => "hi#index"
  get "hi/secret"

  root :to => "hi#index"
end
