class Game < ApplicationRecord
	validates :name, uniqueness: true, allow_blank: false

	has_many :game_questions
	has_many :questions, through: :game_questions

	has_many :game_teams
	has_many :teams, through: :game_teams

	has_one :game_progress

	def game_progress
		return GameProgress.where(
			:game_id => self.id,
		).where.not(
			:status => 'done'
		).first
	end
end