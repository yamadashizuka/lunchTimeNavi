class lunchComentsController < ApplicationController
  # GET /lunch_coments
  # GET /lunch_coments.json
  def index
    @lunch_coments = lunchComent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lunch_coments }
    end
  end

  # GET /lunch_coments/1
  # GET /lunch_coments/1.json
  def show
    @lunch_coment = lunchComent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lunch_coment }
    end
  end

  # GET /lunch_coments/new
  # GET /lunch_coments/new.json
  def new
    @lunch_coment = lunchComent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lunch_coment }
    end
  end

  # GET /lunch_coments/1/edit
  def edit
    @lunch_coment = lunchComent.find(params[:id])
  end

  # POST /lunch_coments
  # POST /lunch_coments.json
  def create
    @lunch_coment = lunchComent.new(params[:lunch_coment])

    respond_to do |format|
      if @lunch_coment.save
        format.html { redirect_to @lunch_coment, notice: 'lunch coment was successfully created.' }
        format.json { render json: @lunch_coment, status: :created, location: @lunch_coment }
      else
        format.html { render action: "new" }
        format.json { render json: @lunch_coment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lunch_coments/1
  # PUT /lunch_coments/1.json
  def update
    @lunch_coment = lunchComent.find(params[:id])

    respond_to do |format|
      if @lunch_coment.update_attributes(params[:lunch_coment])
        format.html { redirect_to @lunch_coment, notice: 'lunch coment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lunch_coment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lunch_coments/1
  # DELETE /lunch_coments/1.json
  def destroy
    @lunch_coment = lunchComent.find(params[:id])
    @lunch_coment.destroy

    respond_to do |format|
      format.html { redirect_to lunch_coments_url }
      format.json { head :no_content }
    end
  end
end
