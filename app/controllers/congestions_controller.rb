class CongestionsController < ApplicationController
  # GET /congestions
  # GET /congestions.json
  def index
    @congestions = Congestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @congestions }
    end
  end

  # GET /congestions/1
  # GET /congestions/1.json
  def show
    @congestion = Congestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @congestion }
    end
  end

  # GET /congestions/new
  # GET /congestions/new.json
  def new
    @congestion = Congestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @congestion }
    end
  end

  # GET /congestions/1/edit
  def edit
    @congestion = Congestion.find(params[:id])
  end

  # POST /congestions
  # POST /congestions.json
  def create
    @congestion = Congestion.new(params[:congestion])

    respond_to do |format|
      if @congestion.save
        format.html { redirect_to @congestion, notice: 'Congestion was successfully created.' }
        format.json { render json: @congestion, status: :created, location: @congestion }
      else
        format.html { render action: "new" }
        format.json { render json: @congestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /congestions/1
  # PUT /congestions/1.json
  def update
    @congestion = Congestion.find(params[:id])

    respond_to do |format|
      if @congestion.update_attributes(params[:congestion])
        format.html { redirect_to @congestion, notice: 'Congestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @congestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /congestions/1
  # DELETE /congestions/1.json
  def destroy
    @congestion = Congestion.find(params[:id])
    @congestion.destroy

    respond_to do |format|
      format.html { redirect_to congestions_url }
      format.json { head :no_content }
    end
  end
end
