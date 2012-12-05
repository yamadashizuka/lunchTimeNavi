class Restaurant < ActiveRecord::Base
  has_many :lunches
  belongs_to :congestion
  before_destroy :ensure_not_referenced_by_any_lunch

  attr_accessible :address, :email, :fridayUp, :startTime, :memo, :mondayUp, :name, :reservation, :saturdayUp, :sundayUp, :telephoneNumber, :thursdayUp, :endTime, :tuesdayUp, :url, :wednesdayUp, :postcode,:congestion_id

  validates :name, uniqueness: true
  validates :name, presence: true
  
  private
  
  def ensure_not_referenced_by_any_lunch
    if lunches.empty?
      return true
    else
      errors.add(:base, 'This restaurant has lunches')
      return false
    end
  end
end
