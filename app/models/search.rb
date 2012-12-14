class Search

  attr_accessor :restaurantName, :address, :genre_id, :rating_id, :reservation

  def initialize(params)
    @restaurantName = params[:restaurantName]
    @address        = params[:address]
    @genre_id       = params[:genre_id]
    @rating_id      = params[:rating_id]
    @reservation    = params[:reservation]
  end
  
  def initialize(restaurantName, address, genre_id, rating_id, reservation)
    @restaurantName = restaurantName
    @address        = address
    @genre_id       = genre_id
    @rating_id      = rating_id
    @reservation    = reservation
  end

end
