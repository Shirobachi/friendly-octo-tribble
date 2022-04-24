class CreateRules < ActiveRecord::Migration[7.0]
  def change
    create_table :rules do |t|
      t.string :content
      t.integer :orderID, auto_increment: true

      t.timestamps
    end
  end
end
