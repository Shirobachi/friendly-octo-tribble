class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :ansA
      t.string :ansB
      t.string :ansC
      t.string :ansD
      t.integer :points
      t.integer :time
      t.string :justificationUrl
      t.string :justification

      t.timestamps
    end
  end
end
