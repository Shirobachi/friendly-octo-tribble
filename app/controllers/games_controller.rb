class GamesController < ApplicationController
	before_action :set_game, only: %i[ show edit update destroy ]
	after_action :check_if_game_is_ready, only: [:toggle_question, :smart_questions, :toggle_team]

	# GET /games or /games.json
	def index
		@games = Game.all
	end

	# GET /games/new
	def new
		@game = Game.new
	end

	def check_if_game_is_ready
		# count questions and teams in game
		game_questions = GameQuestion.where(:game_id => params[:id])
		game_teams = GameTeam.where(:game_id => params[:id])

		# check if both > 0
		if @game
			if game_questions.count > 0 && game_teams.count > 1
				@game.update(:status => "ready")
			else
				@game.update(:status => "configuring")
			end
		end

		@game.save

	end

	# POST /games or /games.json
	def create
		# check if no name is given
		if params[:game][:name].empty?
			# replce with date DD-MM-YYYY
			params[:game][:name] = Date.today.strftime("%d-%m-%Y")
		end

		@game = Game.new(game_params)

		respond_to do |format|
			if @game.save
			format.html { redirect_to actions: "index", notice: t('succed.game.create') }
			format.json { render :show, status: :created, location: @game }
			else
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: @game.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /games/1 or /games/1.json
	def update
		# check if no name is given
		if params[:game][:name].empty?
			# replce with date DD-MM-YYYY
			params[:game][:name] = Date.today.strftime("%d-%m-%Y")
		end
		
		respond_to do |format|
			if @game.update(game_params)
				format.html { redirect_to games_path, notice: t('succed.game.update') }
				format.json { render :show, status: :ok, location: @game }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @game.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /games/1 or /games/1.json
	def destroy
		@game_questions = GameQuestion.where(:game_id => @game.id)
		@game_answers = Answer.where(:game_id => @game.id)
		@game_teams = GameTeam.where(:game_id => @game.id)
		@game_progresses = GameProgress.where(:game_id => @game.id)

		if @game_questions.count == 0 && @game_answers.count == 0 && @game_teams.count == 0 && @game_progresses.count == 0
			@game.destroy

			respond_to do |format|
				format.html { redirect_to games_path, notice: t('succed.game.delete') }
				format.json { head :no_content }
			end
		else
			respond_to do |format|
				format.html { redirect_to games_path, notice: t('succed.game.cannotelete') }
				format.json { head :no_content }
			end
		end
	end

	def questions
		@game = Game.find(params[:id])
		@name = @game.name
		@questions = Question.all.order(:used)

		if @game.status == "done" || @game.status == "running"
			redirect_to games_path, notice: t('succed.game.runned')
			return
		end

		# get all possible questions points uniq
		@points = @questions.map { |q| q.points }.uniq
	end

	def toggle_question(game_id = nil, question = nil, redirect = true)
		@game = Game.find(game_id || params[:id])
		@question = Question.find(question || params[:question])

		if @game.questions.include?(@question)
			@game.questions.delete(@question)
			@question.decrement!(:used)
		else
			@game.questions << @question
			@question.increment!(:used)
		end

		if redirect
			respond_to do |format|
				format.html { redirect_to game_questions_path(@game) }
				format.json { head :no_content }
			end
		end
	end	

	def smart_questions
		# Get question with point params[:points] and not used in this game
		@questions = Question.where(
			points: params[:points],
			active: true
		).order(:used).limit(params[:limit]).to_a

		game_id = params[:game]
		game_questions = GameQuestion.where(:game_id => game_id)
		@questions = @questions - game_questions.map { |q| q.question }

		# Add each question to game by toggle_question
		@questions.each do |question|
			toggle_question(game_id, question.id, false)
		end

		# redirect to game_questions_path
		respond_to do |format|
			format.html { redirect_to game_questions_path(game_id) }
			format.json { head :no_content }
		end
	end

	def teams
		@game_id = params[:id]
		@game = Game.find(@game_id)
		@name = @game.name
		@teams = Team.all.order(:orderID)
		
		if @game.status == "done" || @game.status == "running"
			redirect_to games_path, notice: t('succed.game.runned')
			return
		end
	end

	def toggle_team
		@game = Game.find(params[:id])
		@team = Team.find(params[:team])

		if @game.teams.include?(@team)
			@game.teams.delete(@team)
		else
			@game.teams << @team
		end

		respond_to do |format|
			format.html { redirect_to game_teams_path(@game) }
			format.json { head :no_content }
		end
	end

	def game
		@gp = GameProgress.where.not(
			:status => 'done'
		).first

		if ! @gp.nil?
			prepare_game_vars(@gp.game_id)
			
			if @gp.status == "rules"
				@rules = Rule.all().order(:orderID)
			end

		end

	end 

	def prepare_game_vars(game_id = nil)
		if ! game_id.nil?
			params[:id] = game_id
		end
		@gp = GameProgress.find_by(:game_id => params[:id])

		@question = Question.find(@gp.question_id)
		teams_id = GameTeam.where(:game_id => params[:id])
		@teams = Team.where(:id => teams_id.map { |t| t.team_id })

		questions_id = GameQuestion.where(:game_id => params[:id])
		@questions = Question.where(:id => questions_id.map { |q| q.question_id })

		@questions_done = 0
		@questions.each do |q|
			if q.is_all_answer(@gp.game_id)
				@questions_done += 1 
			end
		end
		@questions_remaining = @questions.count - @questions_done
		
		if @gp.status == "scoreboard"

			@team_scoreboard = []

			@teams.each do |team|
				team_score = team.get_score(@gp.game_id)
				@team_scoreboard.push({
					"team" => team,
					"score" => team_score
				})
			end
			# sort
			@team_scoreboard = @team_scoreboard.sort_by { |hsh| hsh[:score] }.reverse
		end
	end

	def play
		# Check if any game has status 'running'
		@games = Game.where(:status => "running")
		if @games.count > 0
			# Check if games has game with id as params[:id]
			if @games.first.id.to_i == params[:id].to_i
				# Play game (someone clicked on the running game)
				prepare_game_vars
			else
				# redirect to games_path
				redirect_to games_path, notice: t('succed.game.running')
			end
		else
			# find game with status 'ready'
			@game = Game.find(params[:id])
			@game.update(:status => "running")
			@game.save

			# Get game's questions
			@questions = GameQuestion.where(:game_id => @game.id)
			@question = @questions.first.id

			# Make new game_progress
			@game_progress = GameProgress.new(
				:game_id => @game.id, 
				:question_id => @question,
				:status => "rules"
			)
			@game_progress.save()
			add_webhook_record

			prepare_game_vars
		end
	end

	def play_answer
		# Remove old answer
		Answer.where(:game_id => params[:id], :question_id => params[:question], :team_id => params[:team]).destroy_all

		# Create new answer
		@answer = Answer.new(
			:game_id => params[:id],
			:question_id => params[:question],
			:team_id => params[:team],
			:answer => params[:answer]
		)
		@answer.save()

		# If that was the last answer send webhook
		if Question.find( params[:question] ).is_all_answer(params[:id])
			add_webhook_record			
		end

		# Redirect
		respond_to do |format|
			format.html { redirect_to game_play_path(params[:id]) }
			format.json { head :no_content }
		end
	end

	def play_next
		# Get game_progress
		gp = GameProgress.where(
			:game_id => params[:id],
		).where.not(
			:status => "done"
		)

		# Change status to play
		if gp.first.status != "play" && gp.first.status != "done"
			gp.first.update(:status => "play")
			gp.first.save()

			# Send webhook
			add_webhook_record

			# Redirect
			respond_to do |format|
				format.html { redirect_to game_play_path(params[:id]) }
				format.json { head :no_content }
			end

			return # Do not change q if that was break or scoreboard
		end
		

		if ! gp.first.get_next_question.nil?
			if Question.find(gp.first.question_id).is_all_answer(gp.first.game_id)
				gp.first.update(
					:question_id => gp.first.get_next_question
				)
				gp.first.save()

				add_webhook_record

				# Redirect
				respond_to do |format|
					format.html { redirect_to game_play_path(params[:id]) }
					format.json { head :no_content }
				end
			else
				respond_to do |format|
					format.html { redirect_to game_play_path(params[:id]), notice: t('succed.question.answer') }
					format.json { head :no_content }
				end
			end
		else
			gp.first.update(:status => "done")
			gp.first.save()

			game = Game.find(gp.first.game_id)
			game.update(:status => "finished")

			# Change teams best score
			teams_id = GameTeam.where(:game_id => params[:id])
			teams = Team.where(:id => teams_id.map { |t| t.team_id })
			teams.each do |t|
				if t.bestScore < t.get_score(params[:id])
					t.update(:bestScore => t.get_score(params[:id]))
				end
			end

			add_webhook_record

			redirect_to games_path, notice: t('succed.game.finished')
		end
	end

	def play_scoreboard
		gp = GameProgress.where(
			:game_id => params[:id],
		).where.not(
			:status => "done"
		)

		gp.first.update(:status => "scoreboard")
		gp.first.save()

		add_webhook_record

		# Redirect
		respond_to do |format|
			format.html { redirect_to game_play_path(params[:id]) }
			format.json { head :no_content }
		end
	end

	def play_break
		gp = GameProgress.where(
			:game_id => params[:id],
		).where.not(
			:status => "done"
		)

		gp.first.update(:status => "break")
		gp.first.save()

		add_webhook_record

		# Redirect
		respond_to do |format|
			format.html { redirect_to game_play_path(params[:id]) }
			format.json { head :no_content }
		end
	end

	def add_webhook_record
		# Add info to reload game root page
		Webhook.create(
			:lang => I18n.locale == :pl ? 'pl' : 'en'
		)
	end

	def play_show_question
		gp = GameProgress.where(
			:game_id => params[:id],
		).where.not(
			:status => "done"
		)

		gp.first.update(:status => "play")
		gp.first.save()
		
		add_webhook_record

		# Redirect
		respond_to do |format|
			format.html { redirect_to game_play_path(params[:id]) }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_game
		@game = Game.find(params[:id])
	end

	# Only allow a list of trusted parameters through.
	def game_params
		params.require(:game).permit(:name, :status)
	end
end
