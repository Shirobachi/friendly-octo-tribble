class ChangeTeamBestScoreDefault < ActiveRecord::Migration[7.0]
  def change
		change_column_default :teams, :bestScore, -1
  end
end
