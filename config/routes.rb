Plusplus::Application.routes.draw do
  root :to => 'home#index'
  get "/impressum" => 'home#impressum'
  get "/sponsoring" => 'home#sponsoring'
  get "/credits" => 'home#credits'
  get "/admin" => 'home#admin'
  get "/about" => 'home#about'
  
  devise_for :users,:controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:index]
  resources :news, :only => [:index, :show]
  
  namespace :admin do
    resources :sponsors
    resources :users, :only => [:index, :edit, :update, :destroy] do
      member do
        get 'check_in'
        get 'check_out'
      end
    end
    resources :news
  end
end
