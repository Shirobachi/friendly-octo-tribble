class Webhook < ApplicationRecord
  belongs_to :game_progress

	def self.clear_last_weebhook
		last_gp_id = GameProgress.all.order(:id).last.id
		Webhook.where(game_progress_id: last_gp_id).last.destroy
	end

end
