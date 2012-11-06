class CreateLunches < ActiveRecord::Migration
  def change
    create_table :lunches do |t|
      t.string :name
      t.integer :price
      t.references :genre
      t.references :restaurant
      
      t.timestamps
    end
    add_index :lunches, :genre_id
    add_index :lunches, :restaurant_id
  end
end
