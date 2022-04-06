class ChangeTeamBestScoreDefaultValue < ActiveRecord::Migration[7.0]
  def change
		change_column :teams, :bestScore, :integer, deafult: "0"
  end
end