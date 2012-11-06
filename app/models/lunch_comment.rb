class LunchComment < ActiveRecord::Base
  belongs_to :rating
  belongs_to :lunch
  attr_accessible :name, :text, :lunch_id, :rating_id
end
