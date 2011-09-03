Rubypair::Application.routes.draw do
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy'
  match '/about' => 'home#about'

  match '/search' => 'home#search'

  root :to => "home#index"

  resources :users, :only => [:edit, :update, :show]
end
