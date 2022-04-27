class Game < ApplicationRecord
	validates :name, uniqueness: true

	has_many :game_questions
	has_many :questions, through: :game_questions
end
