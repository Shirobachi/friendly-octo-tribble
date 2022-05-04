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

	def lang
		# save cookie
		cookies[:lang] = {
			value: params[:lang],
			expires: 1.year.from_now
		}

		lang = params[:lang] == 'en' ? 'English' : 'Polski'

		if params[:type] == 'admin'
			redirect_to menu_path, notice: "Language changed to #{lang}"
		else
			redirect_to root_path
		end
	end

	def webhook

		render :json => {
			"count": Webhook.get_webhook_record,
			"lang": Webhook.lang
		}
	end
end
