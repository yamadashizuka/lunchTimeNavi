class CreateLaunchComents < ActiveRecord::Migration
  def change
    create_table :launch_coments do |t|
      t.text :launch_coment_text
      t.string :name

      t.timestamps
    end
  end
end
