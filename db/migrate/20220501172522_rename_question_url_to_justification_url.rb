class RenameQuestionUrlToJustificationUrl < ActiveRecord::Migration[7.0]
  def change
		# Raname column
		rename_column :questions, :questionUrl, :justificationUrl
  end
end
