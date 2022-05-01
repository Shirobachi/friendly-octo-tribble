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
	get 'games/:id/play/next' => 'games#play_next', as: :game_play_next
	get 'games/:id/play/break' => 'games#play_break', as: :game_play_break
	get 'games/:id/play/scoreboard' => 'games#play_scoreboard', as: :game_play_scoreboard
	get 'games/:id/play/showQuestion' => 'games#play_show_question', as: :game_play_show_question

	# https://guides.rubyonrails.org/routing.html

	root "games#game"
end
