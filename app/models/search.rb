class Search

  attr_accessor :restaurantName, :address, :genre_id, :rating_id, :reservation

  def initialize(restaurantName, address, genre_id, rating_id, reservation)
    @restaurantName = restaurantName
    @address        = address
    @genre_id       = genre_id
    @rating_id      = rating_id
    @reservation    = reservation
  end
  
end
