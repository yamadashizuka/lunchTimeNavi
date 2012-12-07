# coding: utf-8

class SummaryListsController < ApplicationController
	# 初期表示 -----------------------------------------------
	def index
	
		@genres = Genre.all
		@ratings = Rating.all
	
		@ary = Array.new

		restaurants = Restaurant.order(:name)
		
		restaurants.each do |restaurant|
			lunches = restaurant.lunches.order(:name)
			if ( lunches == nil ) || ( lunches.size < 1 )
				 @ary << [ restaurant, nil, nil ]
			else
				lunches.each do |lunch|
					lunch_comments = lunch.lunch_comments.sort_by{|lunch_comment| -lunch_comment.created_at.to_i}
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
		# respond_to do |format|
		#	format.html # index.html.erb
		#	format.json { render json: @ary }
		# end

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
		
		@search = Search.new(search_restaurantName, search_address, search_genre_id, search_rating_id, search_reservation)

		# debug code
		#p "search_restaurantName = " + @search.restaurantName
		#p "search_address        = " + @search.address
		#p "search_genre_id       = " + @search.genre_id
		#p "search_rating_id      = " + @search.rating_id
		#p "search_reservation    = " + @search.reservation.to_s

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
						lunch_comments = lunch.lunch_comments.all
					else
						lunch_comments = lunch.lunch_comments.all(:conditions => ["rating_id >= ?", rating_id])
					end
					lunch_comments = lunch.lunch_comments.sort_by{|lunch_comment| -lunch_comment.created_at.to_i}
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
		respond_to do |format|
			format.html # search.html.erb
			format.json { render json: @ary }
		end
	end
end
