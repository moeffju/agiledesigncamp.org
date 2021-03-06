Plusplus::Application.routes.draw do
  root :to => 'home#index'
  get "/humans.txt" => 'home#humanstxt', :format => :text, :as => :humanstxt
  get "/impressum" => 'home#impressum'
  get "/sponsoring" => 'home#sponsoring'
  get "/credits" => 'home#credits'
  get "/about" => 'home#about'
  get "/sponsors" => 'home#sponsors'
  get "/timetable" => 'home#timetable'
  
  get "/admin" => 'home#admin'
  
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
      resources :tokens, :only => [:show, :destroy]
    end
    resources :news
  end
end
