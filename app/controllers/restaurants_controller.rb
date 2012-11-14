# encoding: UTF-8
class RestaurantsController < ApplicationController
  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @restaurants }
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurant }
    end
  end

  # GET /restaurants/new
  # GET /restaurants/new.json
  def new
    @restaurant = Restaurant.new
    @genres = Genre.all
    @ratings = Rating.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  # POST /restaurants
  # POST /restaurants.json
  def create

#暫定策↓

    # 1.paramsからlunch_commentを取り出してlunch_commentを消す
    paramtmp_c = params[:restaurant][:lunch][:lunch_comment]
    params[:restaurant][:lunch].delete(:lunch_comment)

    # 2.paramsからlunchを取り出してlunchを消す
    paramtmp_l = params[:restaurant][:lunch]
    params[:restaurant].delete(:lunch)

    # 3.paramsからrestaurantを取り出す
    paramtmp_r = params[:restaurant]

    #restaurant→lunch→lunch_commentの順に作って中身を詰める。
    @restaurant = Restaurant.new(paramtmp_r)
    @restaurant.lunches.new(paramtmp_l)
    @restaurant.lunches.each do |thelunch|	#lunch毎にlunch_commentsをつめる
      thelunch.lunch_comments.new(paramtmp_c)
    end

#↑暫定策

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render json: @restaurant, status: :created, location: @restaurant }
      else
        format.html { render action: "new" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.json
  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end
end
