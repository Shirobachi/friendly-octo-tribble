class RenamejustificationUrlToJustificationUrl < ActiveRecord::Migration[7.0]
  def change
		# Ranme column
		rename_column :questions, :justificationUrl, :justificationUrl
  end
end
