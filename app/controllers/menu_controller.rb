class MenuController < ApplicationController
	
	def deactivate
		questions = Question.where(
			used: params[:used]..,
			active: true
		)

		redirect_to menu_misc_path, notice: t('succed.question.deactivate', count: questions.count)

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

		redirect_to menu_misc_path, notice: t('succed.question.activate', count: c)
	end

	def lang
		# save cookie
		cookies[:lang] = {
			value: params[:lang],
			expires: 1.year.from_now
		}

		lang = params[:lang] == 'en' ? 'English' : 'Polski'

		if params[:type] == 'admin'
			redirect_to menu_path, notice: t('succed.language.change', lang: lang)
		else
			redirect_to root_path
		end
	end
end
