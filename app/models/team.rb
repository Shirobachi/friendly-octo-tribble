class Team < ApplicationRecord
	validates :name, presence: true
	validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

	has_many :game_teams
	has_many :games, through: :game_teams

	def get_answer(question_id, game_id)
		answer =  Answer.where(
			:question_id => question_id, 
			:team_id => self.id, 
			:game_id => game_id
		).first

		if answer.nil?
			return nil
		else
			return answer.answer
		end
	end

	def get_score(game_id)
		return Answer.where(
			:team_id => self.id,
			:game_id => game_id,
			:answer => "A"
		).count
	end
end
