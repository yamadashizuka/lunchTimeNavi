class SummaryListsController < ApplicationController
  def index
  
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
  end
  
end