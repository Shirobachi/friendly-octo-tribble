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
	end

	def toggle_question
		@game = Game.find(params[:id])
		@question = Question.find(params[:question])

		if @game.questions.include?(@question)
			@game.questions.delete(@question)
			@question.decrement!(:used)
		else
			@game.questions << @question
			@question.increment!(:used)
		end

		respond_to do |format|
			format.html { redirect_to game_questions_path(@game) }
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
