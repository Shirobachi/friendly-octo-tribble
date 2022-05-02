class GameProgress < ApplicationRecord
	validates :game_id, presence: true, uniqueness: true
	validates :question_id, presence: true
	validates :status, presence: true

	belongs_to :game
  belongs_to :question

	def get_next_question
		# Get game's questions
		@questions = GameQuestion.where(:game_id => self.game_id)

		# Get next question
		@question = @questions.where("id > ?", self.question_id).first

		# Return next question
		if @question.nil?
			return nil
		else
			return @question.id
		end
	end

	def clear_webhooks
		# Clear webhooks
		Webhook.where(:game_progress_id => self.id).destroy_all
	end

	def add_webhook_record
		# Add webhook record
		Webhook.create(
			:game_progress_id => self.id,
			:lang => I18n.locale == :pl ? 'pl' : 'en'
		)
	end

end
