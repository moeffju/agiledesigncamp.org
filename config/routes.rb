Plusplus::Application.routes.draw do
  root :to => 'home#index'
  match "/rsvp" => 'home#rsvp'

  
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "home#index"
  get '/signin' => "sessions#signin"
  get "/signout" => "sessions#destroy", :as => :signout

end
