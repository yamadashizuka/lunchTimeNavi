class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :telephoneNumber
      t.boolean :reservation
      t.string :memo
      t.string :url
      t.string :email
      t.boolean :sundayUp
      t.boolean :mondayUp
      t.boolean :tuesdayUp
      t.boolean :wednesdayUp
      t.boolean :thursdayUp
      t.boolean :fridayUp
      t.boolean :saturdayUp
      t.time :startTime
      t.time :endTime

      t.timestamps
    end
  end
end


