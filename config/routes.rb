Rails.application.routes.draw do
  resources :games, :rules, :teams, :questions
	
	get 'menu', to: 'menu#index', as: :menu

	get 'games/:id/questions' => 'games#questions', as: :game_questions
  get 'games/:id/questions/:question' => 'games#toggle_question', as: :toggle_question
	

	# https://guides.rubyonrails.org/routing.html

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
