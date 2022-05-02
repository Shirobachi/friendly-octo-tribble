class AddNewColumnToWebhook < ActiveRecord::Migration[7.0]
  def change
		add_column :webhooks, :lang, :string
  end
end
