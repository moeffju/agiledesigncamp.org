Plusplus::Application.routes.draw do
  root :to => 'home#index'
  get "/humans.txt" => 'home#humanstxt', :format => :text, :as => :humanstxt
  get "/impressum" => 'home#impressum'
  get "/sponsoring" => 'home#sponsoring'
  get "/credits" => 'home#credits'
  get "/admin" => 'home#admin'
  get "/about" => 'home#about'
  
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "home#index"
  get "/signin" => "sessions#signin"
  get "/signout" => "sessions#destroy", :as => :signout
  
  resources :users, :only => [:index]
  get '/register' => 'users#register', :as => :registration_form
  put '/register' => 'users#register'
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
