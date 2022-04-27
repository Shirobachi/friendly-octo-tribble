class AddUsedToQuestions < ActiveRecord::Migration[7.0]
  def change
		add_column :questions, :used, :integer, default: 0
  end
end
