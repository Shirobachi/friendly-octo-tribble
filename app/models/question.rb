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
end
