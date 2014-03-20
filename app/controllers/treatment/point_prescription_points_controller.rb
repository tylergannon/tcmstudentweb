class Treatment::PointPrescriptionPointsController < ApplicationController
  before_action :set_treatment_point_prescription_point, only: [:show, :edit, :update, :destroy]

  # GET /treatment/point_prescription_points
  # GET /treatment/point_prescription_points.json
  def index
    @treatment_point_prescription_points = Treatment::PointPrescriptionPoint.all
  end

  # GET /treatment/point_prescription_points/1
  # GET /treatment/point_prescription_points/1.json
  def show
  end

  # GET /treatment/point_prescription_points/new
  def new
    @treatment_point_prescription_point = Treatment::PointPrescriptionPoint.new
  end

  # GET /treatment/point_prescription_points/1/edit
  def edit
  end

  # POST /treatment/point_prescription_points
  # POST /treatment/point_prescription_points.json
  def create
    @treatment_point_prescription_point = Treatment::PointPrescriptionPoint.new(treatment_point_prescription_point_params)

    respond_to do |format|
      if @treatment_point_prescription_point.save
        format.html { redirect_to @treatment_point_prescription_point, notice: 'Point prescription point was successfully created.' }
        format.json { render action: 'show', status: :created, location: @treatment_point_prescription_point }
      else
        format.html { render action: 'new' }
        format.json { render json: @treatment_point_prescription_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /treatment/point_prescription_points/1
  # PATCH/PUT /treatment/point_prescription_points/1.json
  def update
    respond_to do |format|
      if @treatment_point_prescription_point.update(treatment_point_prescription_point_params)
        format.html { redirect_to @treatment_point_prescription_point, notice: 'Point prescription point was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @treatment_point_prescription_point }
      else
        format.html { render action: 'edit' }
        format.json { render json: @treatment_point_prescription_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treatment/point_prescription_points/1
  # DELETE /treatment/point_prescription_points/1.json
  def destroy
    @treatment_point_prescription_point.destroy
    respond_to do |format|
      format.html { redirect_to treatment_point_prescription_points_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_point_prescription_point
      @treatment_point_prescription_point = Treatment::PointPrescriptionPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treatment_point_prescription_point_params
      params.require(:treatment_point_prescription_point).permit(:point_prescription_id, :point_id, :reason, :commentary)
    end
end
