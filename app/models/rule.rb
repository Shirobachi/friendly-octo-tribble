class Rule < ApplicationRecord
	validates :content, presence: true
	validates :orderID, presence: true
end
