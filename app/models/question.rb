class Question < ApplicationRecord
	validates :question, presence: true
	validates :ansA, presence: true
	validates :ansB, presence: true
	validates :ansC, presence: true
	validates :ansD, presence: true
	validates :points, presence: true
	validates :time, presence: true
	validates :justificationUrl, allow_blank: true, format: { with: %r{http[s]?:\/\/(www\.)?(.*)?\/?(.)*}i }

	has_many :game_questions
	has_many :games, through: :game_questions

	has_one :game_progress
	
	def is_all_answer(game_id)
		answers = Answer.where(
			:game_id => game_id,
			:question_id => self.id,
		)

		is_all_answers = answers.count == GameTeam.where(
			:game_id => game_id
		).count

		if answers.count > 0 && is_all_answers
			return true
		else
			return false
		end
	end

	def get_answer(answer)
		if answer.downcase == "a"
			return self.ansA
		elsif answer.downcase == "b"
			return self.ansB
		elsif answer.downcase == "c"
			return self.ansC
		elsif answer.downcase == "d"
			return self.ansD
		end
	end

	def order
		order = "abcd"

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

	def count_answers(game_id, answer)
		return Answer.where(
			:game_id => game_id,
			:question_id => self.id,
			:answer => answer.upcase
		).count
	end

end
