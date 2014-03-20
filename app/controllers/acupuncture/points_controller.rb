class Acupuncture::PointsController < ApplicationController
  before_action :set_acupuncture_point, only: [:show, :edit, :update, :destroy]

  # GET /acupuncture/points
  # GET /acupuncture/points.json
  def index
    @acupuncture_points = Acupuncture::Point.all
  end

  # GET /acupuncture/points/1
  # GET /acupuncture/points/1.json
  def show
  end

  # GET /acupuncture/points/new
  def new
    @acupuncture_point = Acupuncture::Point.new
  end

  # GET /acupuncture/points/1/edit
  def edit
  end

  # POST /acupuncture/points
  # POST /acupuncture/points.json
  def create
    @acupuncture_point = Acupuncture::Point.new(acupuncture_point_params)

    respond_to do |format|
      if @acupuncture_point.save
        format.html { redirect_to @acupuncture_point, notice: 'Point was successfully created.' }
        format.json { render action: 'show', status: :created, location: @acupuncture_point }
      else
        format.html { render action: 'new' }
        format.json { render json: @acupuncture_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acupuncture/points/1
  # PATCH/PUT /acupuncture/points/1.json
  def update
    respond_to do |format|
      if @acupuncture_point.update(acupuncture_point_params)
        format.html { redirect_to @acupuncture_point, notice: 'Point was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @acupuncture_point }
      else
        format.html { render action: 'edit' }
        format.json { render json: @acupuncture_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acupuncture/points/1
  # DELETE /acupuncture/points/1.json
  def destroy
    @acupuncture_point.destroy
    respond_to do |format|
      format.html { redirect_to acupuncture_points_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acupuncture_point
      @acupuncture_point = Acupuncture::Point.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acupuncture_point_params
      params.require(:acupuncture_point).permit(:channel_id, :orginal, :pinyin, :chinese, :name_discussion, :commentary, :canonical, :slug)
    end
end
