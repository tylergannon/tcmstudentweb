class Clinic::PatientsController < ApplicationController
  before_action :authenticate_practitioner!
  before_action :set_clinic_patient, only: [:show, :edit, :update, :destroy]

  # GET /clinic/patients
  # GET /clinic/patients.json
  def index
    @clinic_patients = current_practitioner.patients
    respond_with @clinic_patients do |format|
      format.html {
        @clinic_patients = @clinic_patients.page params[:page]
      }
    end
  end

  # GET /clinic/patients/1
  # GET /clinic/patients/1.json
  def show
  end

  # GET /clinic/patients/new
  def new
    @clinic_patient = current_practitioner.patients.new
  end

  # GET /clinic/patients/1/edit
  def edit
  end

  # POST /clinic/patients
  # POST /clinic/patients.json
  def create
    @clinic_patient = current_practitioner.patients.new(clinic_patient_params)

    respond_to do |format|
      if @clinic_patient.save
        format.html { redirect_to @clinic_patient, notice: 'Patient was successfully created.' }
        format.json { render action: 'show', status: :created, location: @clinic_patient }
      else
        format.html { render action: 'new' }
        format.json { render json: @clinic_patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinic/patients/1
  # PATCH/PUT /clinic/patients/1.json
  def update
    respond_to do |format|
      if @clinic_patient.update(clinic_patient_params)
        format.html { redirect_to @clinic_patient, notice: 'Patient was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @clinic_patient }
      else
        format.html { render action: 'edit' }
        format.json { render json: @clinic_patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinic/patients/1
  # DELETE /clinic/patients/1.json
  def destroy
    @clinic_patient.destroy
    respond_to do |format|
      format.html { redirect_to clinic_patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic_patient
      @clinic_patient = current_practitioner.patients.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_patient_params
      params.require(:clinic_patient).permit(:name, :slug)
    end
end
