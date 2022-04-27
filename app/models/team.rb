class Team < ApplicationRecord
	validates :name, presence: true
	validates :quantity, presence: true

	has_many :game_teams
	has_many :games, through: :game_teams
end
