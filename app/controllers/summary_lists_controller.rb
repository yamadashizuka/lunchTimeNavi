# coding: utf-8

class SummaryListsController < ApplicationController
	def index
	
		@genres = Genre.all
		@ratings = Rating.all
	
	##---------------------------検索・データ部分------------------------------------------------------
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

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @ary }
		end
	##---------------------------検索・データ部分------------------------------------------------------
	end


	def search
		@genres = Genre.all
		@ratings = Rating.all

		@ary = Array.new

#		search_restaurantName = params[:search][:restaurantName]
#		search_address        = params[:search][:address]
#		search_genre_id       = params[:search][:genre_id]
#		search_rating_id      = params[:search][:rating_id]
#		search_reservation    = params[:search][:reservation]
		
		@search = Search.new(params[:search])
#		@search = Search.new(search_restaurantName, search_address, search_genre_id, search_rating_id, search_reservation)

		p "search_restaurantName = " + @search.restaurantName
		p "search_address        = " + @search.address
		p "search_genre_id       = " + @search.genre_id
		p "search_rating_id      = " + @search.rating_id

		if @search.reservation
			@search_reservation  = true
		else
			@search_reservation  = false
		end
		
		p "search_reservation    = " + @search_reservation.to_s

		restaurantName = ""
		address        = ""
		genre_id       = ""
		rating_id      = 0
		
		if (@search.restaurantName.nil?) || (@search.restaurantName.size < 1)
			restaurantName = "%"
		else
			restaurantName = "%" + @search.restaurantName + "%"
		end
		
		if (@search.address.nil?) || (@search.address.size < 1)
			address = "%"
		else
			address = "%" + @search.address + "%"
		end
		
		if (@search.genre_id.nil?) || (@search.genre_id.size < 1)
			genre_id = 0
		else
			genre_id = @search.genre_id.to_i
		end
		
		if (@search.rating_id.nil?) || (@search.rating_id.size < 1)
			rating_id = 0
		else
			rating_id = @search.rating_id.to_i
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

			if ( lunches.nil? ) || ( lunches.size < 1 )
				# ジャンル指定でなく、かつ評価指定でない場合、リスト表示する対象とする
				if ( genre_id == 0 ) && ( rating_id == 0 )
					@ary << [ restaurant, nil, nil ]
				end
			else
				lunches.each do |lunch|
					lunch_comments = Array.new
					# 評価指定でない場合
					if rating_id == 0
						lunch_comments = lunch.lunch_comments.all
					else
					# 評価指定である場合
					#指定した評価に一致するもののみ表示する
						lunch_comments = lunch.lunch_comments.all(:conditions => ["rating_id = ?", rating_id])
					end
					if ( lunch_comments.nil? ) || ( lunch_comments.size < 1 )
						# 評価指定でない場合、リスト表示対象
						if rating_id == 0
							@ary << [ restaurant, lunch, nil ]
						end
					else
						lunch_comments = lunch_comments.sort_by{|lunch_comment| -lunch_comment.created_at.to_i}
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
