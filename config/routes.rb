Basestar::Application.routes.draw do
  resources :ais do
    get 'download', :on => :member
    get 'public', :on => :collection
  end

  devise_for :users

  get "hi" => "hi#index"
  get "hi/secret"

  root :to => "hi#index"
end
