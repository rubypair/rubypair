Rubypair::Application.routes.draw do
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy'

  match '/search' => 'home#search'

  root :to => "home#index"

  resources :profiles, :only => [:edit, :update, :show]
end
