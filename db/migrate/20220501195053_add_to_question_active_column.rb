class AddToQuestionActiveColumn < ActiveRecord::Migration[7.0]
  def change
		add_column :questions, :active, :boolean, default: true
  end
end
