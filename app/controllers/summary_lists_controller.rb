# coding: utf-8

class SummaryListsController < ApplicationController
	def index
	
		# 評価項目の検索ステータスを作成
		@rating = Rating.new(:name => '★☆☆')
		@ratings = Rating.order(:name => 'desc')
		# ジャンル項目の検索ステータスを作成
		@genre = Genre.new()
		@genres = Genre.order(:name)
	
	##---------------------------検索・データ部分------------------------------------------------------
		@ary = Array.new

		_restaurants = Restaurant.order(:name)
		
		_restaurants.each do |restaurant|
			_lunches = restaurant.lunches.order(:name)
			if ( _lunches == nil ) || ( _lunches.size < 1 )
				 @ary << [ restaurant, nil, nil ]
			else
				_lunches.each do |lunch|
					_lunch_comments = lunch.lunch_comments.sort_by{|lunch_comment| -lunch_comment.created_at.to_i}
					if ( _lunch_comments == nil ) || ( _lunch_comments.size < 1 )
						@ary << [ restaurant, lunch, nil ]
					else
						_lunch_comments.each do |lunch_comment|
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
		# 評価項目の検索ステータスを作成
		@rating = Rating.new(:name => '★☆☆')
		@ratings = Rating.order(:name => 'desc')
		# ジャンル項目の検索ステータスを作成
		@genre = Genre.new()
		@genres = Genre.order(:name)
		

	##---------------------------検索・データ部分------------------------------------------------------
		@ary = Array.new
		
		# 検索キーワード
		restaurantName = params[:restaurantName]
		address = params[:address]
		genre = params[:genre][:id]
		reservation = false
		if (params[:reservation] == 'on')
			reservation = true
		else
			reservation = false
		end

		sql_WhereSentence = 'name like ? AND address like ? AND reservation = ? ', '%' + restaurantName + '%', '%' + address + '%', reservation
		
		_restaurants = Restaurant.where(sql_WhereSentence).order(:name)
		
		_restaurants.each do |restaurant|
			_lunches = restaurant.lunches.where('genre_id = ?', genre).order(:name)
			if ( _lunches == nil ) || ( _lunches.size < 1 )
				# ジャンル指定でものがない場合、リスト表示対象外
			else
				_lunches.each do |lunch|
					_lunch_comments = lunch.lunch_comments.sort_by{|lunch_comment| -lunch_comment.created_at.to_i}
					if ( _lunch_comments == nil ) || ( _lunch_comments.size < 1 )
						@ary << [ restaurant, lunch, nil ]
					else
						_lunch_comments.each do |lunch_comment|
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


end