class GameProgress < ApplicationRecord
	validates :game_id, presence: true
	validates :question_id, presence: true
	validates :status, presence: true

	belongs_to :game
  belongs_to :question
end
