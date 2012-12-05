class CreateCongestions < ActiveRecord::Migration
  def change
    create_table :congestions do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
