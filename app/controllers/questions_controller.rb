class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions or /questions.json
  def index
    @questions = Question.all.order(:active => :desc, :used => :asc)
  end

  # GET /questions/1 or /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to action: "index", notice: t('succed.question.create') }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to action: 'index', notice: t('succed.question.update') }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
		@question_games = GameQuestion.where(question_id: @question.id)
		@question_game_progresses = GameProgress.where(question_id: @question.id)
		@question_answers = Answer.where(question_id: @question.id)

		if @question_games.count == 0 && @question_game_progresses.count == 0 && @question_answers.count == 0
			@question.destroy

			respond_to do |format|
				format.html { redirect_to questions_url, notice: t('succed.question.delete') }
				format.json { head :no_content }
			end
		else
			respond_to do |format|
				format.html { redirect_to questions_url, notice: t('succed.question.cannotDelete') }
				format.json { head :no_content }
			end
		end
  end

	def toggle_active
		Question.find(params[:question_id]).toggle_active

		respond_to do |format|
			format.html { redirect_to questions_path }
			format.json { head :no_content }
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:question, :ansA, :ansB, :ansC, :ansD, :points, :time, :justificationUrl, :justification)
    end
end
