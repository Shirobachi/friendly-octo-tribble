class GamesController < ApplicationController
	before_action :set_game, only: %i[ show edit update destroy ]

	# GET /games or /games.json
	def index
		@games = Game.all.order(:orderID)
	end

	# GET /games/1 or /games/1.json
	def show
	end

	# GET /games/new
	def new
		@game = Game.new
	end

	# GET /games/1/edit
	def edit
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
			format.html { redirect_to actions: "index", notice: "Game was successfully created." }
			format.json { render :show, status: :created, location: @game }
			else
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: @game.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /games/1 or /games/1.json
	def update
		respond_to do |format|
			if @game.update(game_params)
			format.html { redirect_to actions: "index", notice: "Game was successfully updated." }
			format.json { render :show, status: :ok, location: @game }
			else
			format.html { render :edit, status: :unprocessable_entity }
			format.json { render json: @game.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /games/1 or /games/1.json
	def destroy
		@game.destroy

		respond_to do |format|
			format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	def questions
		@game = Game.find(params[:id])
		@name = @game.name
		@questions = Question.all.order(:used)

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
		@questions = Question.where(points: params[:points]).order(:used).limit(params[:limit])
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