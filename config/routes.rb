Plusplus::Application.routes.draw do
  root :to => 'home#index'
  match "/rsvp" => 'home#rsvp'
  get "/impressum" => 'home#impressum'
  get "/sponsoring" => 'home#sponsoring'
  get "/credits" => 'home#credits'
  get "/admin" => 'home#admin'
  get "/about" => 'home#about'
  
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "home#index"
  get '/signin' => "sessions#signin"
  get "/signout" => "sessions#destroy", :as => :signout
  
  scope '/admin' do
    resources :sponsors
    get '/users' => 'users#index', :as => :users
    get '/users/check_in/:id' => 'users#check_in', :as => :users_check_in
    get '/users/check_out/:id' => 'users#check_out', :as => :users_check_out
  end
end
