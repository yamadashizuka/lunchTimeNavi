# coding: utf-8

class SummaryListsController < ApplicationController
  # 初期表示 -----------------------------------------------
  def index
  
    @genres = Genre.all
    @ratings = Rating.all
    @commentRegistDateFrom = (Date.today-180).strftime("%Y/%m/%d").to_s
    @commentRegistDateTo = Date.today.strftime("%Y/%m/%d").to_s

    search_commentRegistDateFrom = @commentRegistDateFrom.gsub(/\//, "-") + " 00:00:00.000000"
    search_commentRegistDateTo = @commentRegistDateTo.gsub(/\//, "-") + " 00:00:00.000000"

    @ary = Array.new

    restaurants = Restaurant.order(:name)
    
    restaurants.each do |restaurant|
      lunches = restaurant.lunches.order(:name)
      if ( lunches == nil ) || ( lunches.size < 1 )
         @ary << [ restaurant, nil, nil ]
      else
        lunches.each do |lunch|
          lunch_comments = lunch.lunch_comments.all(:order => "created_at", :conditions => ["? <= updated_at and updated_at <= ?", search_commentRegistDateFrom, search_commentRegistDateTo])
          if ( lunch_comments == nil ) || ( lunch_comments.size < 1 )
            @ary << [ restaurant, lunch, nil ]
          else
            lunch_comments.each do |lunch_comment|
              @ary << [ restaurant, lunch, lunch_comment ]
            end
          end
        end
      end
    end

    render :search
		#respond_to do |format|
		#	format.html # index.html.erb
		#	format.json { render json: @ary }
		#end

	end

  def search
  # 検索処理 -----------------------------------------------

    @genres = Genre.all
    @ratings = Rating.all

    @ary = Array.new
    
    # 検索キーワード
    p  params[:search]
    search_restaurantName = params[:search][:restaurantName]
    search_address        = params[:search][:address]
    search_genre_id       = params[:search][:genre_id]
    search_rating_id      = params[:search][:rating_id]
    search_reservation    = params[:search][:reservation]

    search_commentRegistDateFrom = params[:search][:commentRegistDateFrom]
    search_commentRegistDateTo   = params[:search][:commentRegistDateTo]
    @commentRegistDateFrom = search_commentRegistDateFrom
    @commentRegistDateTo = search_commentRegistDateTo
    
    @search = Search.new(search_restaurantName, search_address, search_genre_id, search_rating_id, search_reservation)

    if @search.reservation
      @search_reservation   = true
    else
      @search_reservation   = false
    end
    
    p "@search_reservation   = " + @search_reservation.to_s
    restaurantName = ""
    address        = ""
    genre_id       = ""
    rating_id      = 0

    if (@search.restaurantName.nil?) || (@search.restaurantName.size < 1)
      restaurantName = "%"
    else
      restaurantName = "%" + search_restaurantName + "%"
    end
    
    if (@search.address.nil?) || (@search.address.size < 1)
      address = "%"
    else
      address = "%" + search_address + "%"
    end
    
    if (@search.genre_id.nil?) || (@search.genre_id.size < 1)
      genre_id = 0
    else
      genre_id = search_genre_id
    end
    
    if (@search.rating_id.nil?) || (@search.rating_id.size < 1)
      rating_id = 0
    else
      rating_id = search_rating_id.to_i
    end
    
    if @search.reservation
      restaurants = Restaurant.all(:conditions => ["name like ? and address like ? and reservation = ?",restaurantName, address, "t"], :order => :name)
    else
      restaurants = Restaurant.all(:conditions => ["name like ? and address like ?",restaurantName, address], :order => :name)
    end

    if (search_commentRegistDateFrom.nil?) || (search_commentRegistDateFrom.size < 1)
      search_commentRegistDateFrom = "1000-01-01 00:00:00.000000"
    else
      search_commentRegistDateFrom = search_commentRegistDateFrom.gsub(/\//, "-") + " 00:00:00.000000"
    end
    if (search_commentRegistDateTo.nil?) || (search_commentRegistDateTo.size < 1)
      search_commentRegistDateTo = "9999-12-31 23:59:59.000000"
    else
      search_commentRegistDateTo = search_commentRegistDateTo.gsub(/\//, "-") + " 00:00:00.000000"
    end




    restaurants.each do |restaurant|
      lunches = Array.new
      if genre_id == 0
        lunches = restaurant.lunches.order(:name)
      else
        lunches = restaurant.lunches.where("genre_id = ?", genre_id).order(:name)
      end
            puts "lunches is " + lunches.class.name
      if ( lunches == nil ) || ( lunches.size < 1 )
        # ジャンル指定なく、かつ、評価指定でない場合、リスト表示対象
        if ( genre_id == 0 ) && ( rating_id == 0 )
          @ary << [ restaurant, nil, nil ]
        end
      else
        lunches.each do |lunch|
          lunch_comments = Array.new
          if rating_id == 0
            lunch_comments = lunch.lunch_comments.all(:order => "created_at", :conditions => ["? <= updated_at and updated_at <= ?", search_commentRegistDateFrom, search_commentRegistDateTo])
          else
            lunch_comments = lunch.lunch_comments.all(:order => "created_at", :conditions => ["rating_id >= ? and ? <= updated_at and updated_at <= ?", rating_id, search_commentRegistDateFrom, search_commentRegistDateTo] )
          end
          if ( lunch_comments == nil ) || ( lunch_comments.size < 1 )
            # 評価指定でない場合、リスト表示対象
            if rating_id == 0
              @ary << [ restaurant, lunch, nil ]
            end
          else
            lunch_comments.each do |lunch_comment|
              @ary << [ restaurant, lunch, lunch_comment ]
            end
          end
        end
      end
    end
    render :search
    #respond_to do |format|
    #  format.html # search.html.erb
    #  format.json { render json: @ary }
    #end
  end
end
  
