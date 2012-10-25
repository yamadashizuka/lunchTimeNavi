class Restaurant < ActiveRecord::Base
  attr_accessible :address, :email, :fridayUp, :startTime, :memo, :mondayUp, :name, :reservation, :saturdayUp, :sundayUp, :telephoneNumber, :thursdayUp, :endTime, :tuesdayUp, :url, :wednesdayUp
end
