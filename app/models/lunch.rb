class Lunch < ActiveRecord::Base
  belongs_to :genre
  belongs_to :restaurant
  has_many :lunch_comments
  before_destroy :ensure_not_referenced_by_any_lunch_comment

  attr_accessible :name, :price, :genre_id, :restaurant_id
  
  private
  
  def ensure_not_referenced_by_any_lunch_comment
    if lunch_comments.empty?
      return true
    else
      errors.add(:base, 'This lunch has lunch_comments')
      return false
    end
  end
end
