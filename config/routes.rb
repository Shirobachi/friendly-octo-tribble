Rails.application.routes.draw do
  resources :rules
  resources :teams
  get 'menu', to: 'menu#index'

	# https://guides.rubyonrails.org/routing.html

  resources :questions
  get 'test', to: "questions#test"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "menu#index"
end
