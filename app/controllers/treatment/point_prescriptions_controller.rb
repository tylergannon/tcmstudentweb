class Treatment::PointPrescriptionsController < ApplicationController
  before_action :set_treatment_point_prescription, only: [:show, :edit, :update, :destroy]

  # GET /treatment/point_prescriptions
  # GET /treatment/point_prescriptions.json
  def index
    @treatment_point_prescriptions = Treatment::PointPrescription.all
  end

  # GET /treatment/point_prescriptions/1
  # GET /treatment/point_prescriptions/1.json
  def show
  end

  # GET /treatment/point_prescriptions/new
  def new
    @treatment_point_prescription = Treatment::PointPrescription.new
  end

  # GET /treatment/point_prescriptions/1/edit
  def edit
  end

  # POST /treatment/point_prescriptions
  # POST /treatment/point_prescriptions.json
  def create
    @treatment_point_prescription = Treatment::PointPrescription.new(treatment_point_prescription_params)

    respond_to do |format|
      if @treatment_point_prescription.save
        format.html { redirect_to @treatment_point_prescription, notice: 'Point prescription was successfully created.' }
        format.json { render action: 'show', status: :created, location: @treatment_point_prescription }
      else
        format.html { render action: 'new' }
        format.json { render json: @treatment_point_prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /treatment/point_prescriptions/1
  # PATCH/PUT /treatment/point_prescriptions/1.json
  def update
    respond_to do |format|
      if @treatment_point_prescription.update(treatment_point_prescription_params)
        format.html { redirect_to @treatment_point_prescription, notice: 'Point prescription was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @treatment_point_prescription }
      else
        format.html { render action: 'edit' }
        format.json { render json: @treatment_point_prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treatment/point_prescriptions/1
  # DELETE /treatment/point_prescriptions/1.json
  def destroy
    @treatment_point_prescription.destroy
    respond_to do |format|
      format.html { redirect_to treatment_point_prescriptions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_point_prescription
      @treatment_point_prescription = Treatment::PointPrescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treatment_point_prescription_params
      params.require(:treatment_point_prescription).permit(:name, :slug, :commentary, :citation_id, :pattern_id)
    end
end
