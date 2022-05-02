class Webhook < ApplicationRecord
  belongs_to :game_progress

	def self.clear_last_weebhook
		last_gp_id = GameProgress.all.order(:id).last.id
		w = Webhook.where(game_progress_id: last_gp_id)

		if w.count > 0
			w.last.destroy
		end

	end

end
