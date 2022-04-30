class Answer < ApplicationRecord
  belongs_to :game
  belongs_to :question
  belongs_to :team
end
