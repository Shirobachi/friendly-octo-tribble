class Webhook < ApplicationRecord
	def self.add_webhook_record
		# Add webhook record
		p "Added webhook record"
		p "Added webhook record"

		Webhook.create(
			:lang => I18n.locale == :pl ? 'pl' : 'en'
		)

		p "Added webhook record"
		p "Added webhook record"
		
	end

	def self.get_webhook_record
		# Get webhook record
		return Webhook.all.count
	end
	
	def self.lang
		l = Webhook.all.last.lang
		
		return l || 'en'
	end

end
