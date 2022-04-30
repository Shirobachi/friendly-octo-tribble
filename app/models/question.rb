class Question < ApplicationRecord
	validates :question, presence: true
	validates :ansA, presence: true
	validates :ansB, presence: true
	validates :ansC, presence: true
	validates :ansD, presence: true
	validates :points, presence: true
	validates :time, presence: true

	has_many :game_questions
	has_many :games, through: :game_questions

	has_one :game_progress
	
	def is_any_answer(game_id)
		answers = Answer.where(
			:game_id => game_id,
			:question_id => self.id,
		)

		if answers.count > 0
			gp = GameProgress.where(
				:game_id => game_id,
				:question_id => self.id,
			)
			if gp.nil?
				return true
			else
				return false
			end
		else
			return false
		end
	end
end
