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

		the_game = GameProgress.where(
			:game_id => game_id 
		).where.not(
			:status => "done"
		).first

		if answers.count > 0 && the_game.question_id != self.id
			return true
		else
			return false
		end
	end

	def get_order
		order = "abcs"

		hash = self.id.hash()

		if hash.to_s.length % 2 != 0
			hash = hash.to_s + "0"
		end

		for i in 0..hash.to_s.length-1
			i1 = i.to_i%order.length
			i2 = (i+1).to_i%order.length
			
			# swap i1 and i2
			temp = order[i1]
			order[i1] = order[i2]
			order[i2] = temp

			i += 1
		end

		return order

	end
end
