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
end
