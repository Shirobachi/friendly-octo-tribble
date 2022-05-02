class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]

  # GET /teams or /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

	# POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to actions: "index", notice: t('succed.team.create') }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to questions_path, notice: t('succed.team.update') }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
		@team_answers = Answer.where(team_id: @team.id)
		@team_games = GameTeam.where(team_id: @team.id)

		if @team_answers.count == 0 && @team_games.count == 0
			@team.destroy
			
			respond_to do |format|
				format.html { redirect_to teams_path, notice: t('succed.team.delete') }
				format.json { head :no_content }
			end
		else
			respond_to do |format|
				format.html { redirect_to teams_path, notice: "Cannot remove team who was take part game or is assign to one!" }
				format.json { head :no_content }
			end
		end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :bestScore, :linkToPhoto, :quantity)
    end
end
