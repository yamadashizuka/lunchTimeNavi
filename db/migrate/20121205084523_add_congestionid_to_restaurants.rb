class AddCongestionidToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :congestion_id, :integer
  end
end
