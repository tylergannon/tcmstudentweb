class Diagnosis::SymptomsController < ApplicationController
  before_action :set_diagnosis_symptom, only: [:show, :edit, :update, :destroy]

  # GET /diagnosis/symptoms
  # GET /diagnosis/symptoms.json
  def index
    @diagnosis_symptoms = Diagnosis::Symptom.all
  end

  # GET /diagnosis/symptoms/1
  # GET /diagnosis/symptoms/1.json
  def show
  end

  # GET /diagnosis/symptoms/new
  def new
    @diagnosis_symptom = Diagnosis::Symptom.new
  end

  # GET /diagnosis/symptoms/1/edit
  def edit
  end

  # POST /diagnosis/symptoms
  # POST /diagnosis/symptoms.json
  def create
    @diagnosis_symptom = Diagnosis::Symptom.new(diagnosis_symptom_params)

    respond_to do |format|
      if @diagnosis_symptom.save
        format.html { redirect_to @diagnosis_symptom, notice: 'Symptom was successfully created.' }
        format.json { render action: 'show', status: :created, location: @diagnosis_symptom }
      else
        format.html { render action: 'new' }
        format.json { render json: @diagnosis_symptom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagnosis/symptoms/1
  # PATCH/PUT /diagnosis/symptoms/1.json
  def update
    respond_to do |format|
      if @diagnosis_symptom.update(diagnosis_symptom_params)
        format.html { redirect_to @diagnosis_symptom, notice: 'Symptom was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @diagnosis_symptom }
      else
        format.html { render action: 'edit' }
        format.json { render json: @diagnosis_symptom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnosis/symptoms/1
  # DELETE /diagnosis/symptoms/1.json
  def destroy
    @diagnosis_symptom.destroy
    respond_to do |format|
      format.html { redirect_to diagnosis_symptoms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagnosis_symptom
      @diagnosis_symptom = Diagnosis::Symptom.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diagnosis_symptom_params
      params.require(:diagnosis_symptom).permit(:name, :slug)
    end
end
