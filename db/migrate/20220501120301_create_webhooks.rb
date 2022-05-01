class CreateWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks do |t|
      t.references :game_progress, null: false, foreign_key: true

      t.timestamps
    end
  end
end
