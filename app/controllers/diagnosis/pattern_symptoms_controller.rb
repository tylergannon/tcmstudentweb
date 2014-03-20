class Diagnosis::PatternSymptomsController < ApplicationController
  before_action :set_diagnosis_pattern_symptom, only: [:show, :edit, :update, :destroy]

  # GET /diagnosis/pattern_symptoms
  # GET /diagnosis/pattern_symptoms.json
  def index
    @diagnosis_pattern_symptoms = Diagnosis::PatternSymptom.all
  end

  # GET /diagnosis/pattern_symptoms/1
  # GET /diagnosis/pattern_symptoms/1.json
  def show
  end

  # GET /diagnosis/pattern_symptoms/new
  def new
    @diagnosis_pattern_symptom = Diagnosis::PatternSymptom.new
  end

  # GET /diagnosis/pattern_symptoms/1/edit
  def edit
  end

  # POST /diagnosis/pattern_symptoms
  # POST /diagnosis/pattern_symptoms.json
  def create
    @diagnosis_pattern_symptom = Diagnosis::PatternSymptom.new(diagnosis_pattern_symptom_params)

    respond_to do |format|
      if @diagnosis_pattern_symptom.save
        format.html { redirect_to @diagnosis_pattern_symptom, notice: 'Pattern symptom was successfully created.' }
        format.json { render action: 'show', status: :created, location: @diagnosis_pattern_symptom }
      else
        format.html { render action: 'new' }
        format.json { render json: @diagnosis_pattern_symptom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagnosis/pattern_symptoms/1
  # PATCH/PUT /diagnosis/pattern_symptoms/1.json
  def update
    respond_to do |format|
      if @diagnosis_pattern_symptom.update(diagnosis_pattern_symptom_params)
        format.html { redirect_to @diagnosis_pattern_symptom, notice: 'Pattern symptom was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @diagnosis_pattern_symptom }
      else
        format.html { render action: 'edit' }
        format.json { render json: @diagnosis_pattern_symptom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnosis/pattern_symptoms/1
  # DELETE /diagnosis/pattern_symptoms/1.json
  def destroy
    @diagnosis_pattern_symptom.destroy
    respond_to do |format|
      format.html { redirect_to diagnosis_pattern_symptoms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagnosis_pattern_symptom
      @diagnosis_pattern_symptom = Diagnosis::PatternSymptom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diagnosis_pattern_symptom_params
      params.require(:diagnosis_pattern_symptom).permit(:pattern_id, :symptom_id, :commentary, :maybe, :key_symptom, :position)
    end
end
