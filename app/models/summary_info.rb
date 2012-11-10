class SummaryInfo < ActiveRecord::Base
  attr_accessible :restaurant_id, :restaurant_name, :address, :startTime, :endTime, :lunch_id, :lunch_name, :price, :genre_id, :genre_name, :lunch_comment_id, :lunch_comment, :created_at, :rating_id, :rating_name, :rating_value, :user_name
end
