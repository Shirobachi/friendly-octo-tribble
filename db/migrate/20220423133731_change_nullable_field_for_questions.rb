class ChangeNullableFieldForQuestions < ActiveRecord::Migration[7.0]
  def change
		change_column :questions, :question, :string, :null => false
		change_column :questions, :ansA, :string, :null => false
		change_column :questions, :ansB, :string, :null => false
		change_column :questions, :ansC, :string, :null => false
		change_column :questions, :ansD, :string, :null => false
		change_column :questions, :points, :integer, :default => 1
		change_column :questions, :time, :integer, :default => 120
	end
end
