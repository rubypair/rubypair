Rubypair::Application.routes.draw do
  get "comments/create"

  get "comments/edit"

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy'
  match '/about' => 'home#about'

  match '/search' => 'home#search'

  root :to => "home#index"

  resources :users, :only => [:edit, :update, :show] do
    resources :comments
  end
end
