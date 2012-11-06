class Rating < ActiveRecord::Base
  attr_accessible :name, :value
  
  validates :name, :value, uniqueness: true
  validates :name, :value, presence: true
end
