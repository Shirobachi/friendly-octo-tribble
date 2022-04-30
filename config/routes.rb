Rails.application.routes.draw do
  resources :games, :rules, :teams, :questions
	
	get 'menu', to: 'menu#index', as: :menu

	get 'games/:id/questions' => 'games#questions', as: :game_questions
	post 'games/:id/questions' => 'games#smart_questions'
  get 'games/:id/questions/:question' => 'games#toggle_question', as: :toggle_question
	get 'games/:id/teams' => 'games#teams', as: :game_teams
  get 'games/:id/teams/:team' => 'games#toggle_team', as: :toggle_team
	get 'games/:id/play' => 'games#play', as: :game_play
	get 'games/:id/play/:question/:team/:answer' => 'games#play_answer', as: :game_play_answer

	# https://guides.rubyonrails.org/routing.html

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
	root "menu#index"
end
