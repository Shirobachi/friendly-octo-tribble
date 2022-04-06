class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :bestScore
      t.string :linkToPhoto
      t.integer :quantity

      t.timestamps
    end
  end
end
