class Game < ApplicationRecord
	validates :name, uniqueness: true

	has_many :game_questions
	has_many :questions, through: :game_questions

	has_many :game_teams
	has_many :teams, through: :game_teams

	belongs_to :game_status, optional: true
end
