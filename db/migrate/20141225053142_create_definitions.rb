class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|
      t.integer :user_id
      t.string :word
      t.string :definition
      t.timestamps
    end
  end
end
