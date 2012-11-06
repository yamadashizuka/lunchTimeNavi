class CreateLunchComments < ActiveRecord::Migration
  def change
    create_table :lunch_comments do |t|
      t.string :text
      t.string :name

      t.timestamps
    end
  end
end
