class Clinic::VisitsController < ApplicationController
  before_action :set_clinic_visit, only: [:show, :edit, :update, :destroy]

  # GET /clinic/visits
  # GET /clinic/visits.json
  def index
    @clinic_visits = Clinic::Visit.all
  end

  # GET /clinic/visits/1
  # GET /clinic/visits/1.json
  def show
  end

  # GET /clinic/visits/new
  def new
    @clinic_visit = Clinic::Visit.new
  end

  # GET /clinic/visits/1/edit
  def edit
  end

  # POST /clinic/visits
  # POST /clinic/visits.json
  def create
    @clinic_visit = Clinic::Visit.new(clinic_visit_params)

    respond_to do |format|
      if @clinic_visit.save
        format.html { redirect_to @clinic_visit, notice: 'Visit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @clinic_visit }
      else
        format.html { render action: 'new' }
        format.json { render json: @clinic_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinic/visits/1
  # PATCH/PUT /clinic/visits/1.json
  def update
    respond_to do |format|
      if @clinic_visit.update(clinic_visit_params)
        format.html { redirect_to @clinic_visit, notice: 'Visit was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @clinic_visit }
      else
        format.html { render action: 'edit' }
        format.json { render json: @clinic_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinic/visits/1
  # DELETE /clinic/visits/1.json
  def destroy
    @clinic_visit.destroy
    respond_to do |format|
      format.html { redirect_to clinic_visits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic_visit
      @clinic_visit = Clinic::Visit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_visit_params
      params.require(:clinic_visit).permit(:patient_id, :appointment_time)
    end
end
