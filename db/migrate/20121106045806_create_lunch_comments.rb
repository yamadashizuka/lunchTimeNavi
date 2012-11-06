class CreateLunchComments < ActiveRecord::Migration
  def change
    create_table :lunch_comments do |t|
      t.string :text
      t.string :name
      t.references :lunch
      t.references :rating
      
      t.timestamps
    end
    add_index :lunch_comments, :lunch_id
    add_index :lunch_comments, :rating_id
  end
end
