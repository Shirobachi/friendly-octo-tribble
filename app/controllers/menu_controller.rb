class MenuController < ApplicationController
	
	def deactivate
		questions = Question.where(
			used: params[:used]..,
			active: true
		)

		redirect_to menu_misc_path, notice: "Deactivated #{questions.count} questions."

		questions.each do |q|
			q.active = false
			q.save
		end
	end
	
	def activate
		questions = Question.where(
			used: ..params[:used],
			active: false
		)
		c = questions.count

		questions.each do |q|
			q.active = true
			q.save
		end

		redirect_to menu_misc_path, notice: "Activated #{c} questions."
	end
end
