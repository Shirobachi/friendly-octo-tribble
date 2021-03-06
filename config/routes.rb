Rails.application.routes.draw do
  resources :games, :rules, :teams, :questions
	
	get 'menu', to: 'menu#index', as: :menu

	get 'games/:id/questions' => 'games#questions', as: :game_questions
	post 'games/:id/questions' => 'games#smart_questions'
  get 'games/:id/questions/:question' => 'games#toggle_question', as: :toggle_question
	get 'questions/:question_id/toggle_active' => 'questions#toggle_active', as: :toggle_active
	
	get 'games/:id/teams' => 'games#teams', as: :game_teams
  get 'games/:id/teams/:team' => 'games#toggle_team', as: :toggle_team

	get 'games/:id/play' => 'games#play', as: :game_play
	get 'games/:id/play/:question/:team/:answer' => 'games#play_answer', as: :game_play_answer
	get 'games/:id/play/next' => 'games#play_next', as: :game_play_next
	get 'games/:id/play/break' => 'games#play_break', as: :game_play_break
	get 'games/:id/play/scoreboard' => 'games#play_scoreboard', as: :game_play_scoreboard
	get 'games/:id/play/showQuestion' => 'games#play_show_question', as: :game_play_show_question

	get 'webhook' => 'menu#webhook', as: :game_webhook

	get 'menu/misc' => 'menu#misc', as: :menu_misc
	post 'menu/misc/deactivate' => 'menu#deactivate', as: :menu_deactivate
	post 'menu/misc/activate' => 'menu#activate', as: :menu_activate

	get 'lang/:type/:lang' => 'menu#lang', as: :lang

	root "games#game"
end
