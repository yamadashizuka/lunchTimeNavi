class LaunchComentsController < ApplicationController
  # GET /launch_coments
  # GET /launch_coments.json
  def index
    @launch_coments = LaunchComent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @launch_coments }
    end
  end

  # GET /launch_coments/1
  # GET /launch_coments/1.json
  def show
    @launch_coment = LaunchComent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @launch_coment }
    end
  end

  # GET /launch_coments/new
  # GET /launch_coments/new.json
  def new
    @launch_coment = LaunchComent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @launch_coment }
    end
  end

  # GET /launch_coments/1/edit
  def edit
    @launch_coment = LaunchComent.find(params[:id])
  end

  # POST /launch_coments
  # POST /launch_coments.json
  def create
    @launch_coment = LaunchComent.new(params[:launch_coment])

    respond_to do |format|
      if @launch_coment.save
        format.html { redirect_to @launch_coment, notice: 'Launch coment was successfully created.' }
        format.json { render json: @launch_coment, status: :created, location: @launch_coment }
      else
        format.html { render action: "new" }
        format.json { render json: @launch_coment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /launch_coments/1
  # PUT /launch_coments/1.json
  def update
    @launch_coment = LaunchComent.find(params[:id])

    respond_to do |format|
      if @launch_coment.update_attributes(params[:launch_coment])
        format.html { redirect_to @launch_coment, notice: 'Launch coment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @launch_coment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /launch_coments/1
  # DELETE /launch_coments/1.json
  def destroy
    @launch_coment = LaunchComent.find(params[:id])
    @launch_coment.destroy

    respond_to do |format|
      format.html { redirect_to launch_coments_url }
      format.json { head :no_content }
    end
  end
end
