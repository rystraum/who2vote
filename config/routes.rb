Who2vote::Application.routes.draw do
  mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'
  devise_for :users

  get "filter" => "home#filter"
  root to: "home#index"
end
