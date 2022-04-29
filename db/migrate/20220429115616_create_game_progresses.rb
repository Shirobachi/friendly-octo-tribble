class CreateGameProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :game_progresses do |t|
      t.references :game, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
