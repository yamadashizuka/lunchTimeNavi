class AddWithDrinkToLunches < ActiveRecord::Migration
  def change
    add_column :lunches, :withdrink, :boolean
  end
end
