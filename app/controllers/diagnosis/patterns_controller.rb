class Diagnosis::PatternsController < ApplicationController
  before_action :set_diagnosis_pattern, only: [:show, :edit, :update, :destroy]

  # GET /diagnosis/patterns
  # GET /diagnosis/patterns.json
  def index
    @diagnosis_patterns = Diagnosis::Pattern.all
    
    respond_with @diagnosis_patterns do |format|
      format.html {
        @diagnosis_patterns = @diagnosis_patterns.page params[:page]
      }
    end
  end

  # GET /diagnosis/patterns/1
  # GET /diagnosis/patterns/1.json
  def show
  end

  # GET /diagnosis/patterns/new
  def new
    @diagnosis_pattern = Diagnosis::Pattern.new
  end

  # GET /diagnosis/patterns/1/edit
  def edit
  end

  # POST /diagnosis/patterns
  # POST /diagnosis/patterns.json
  def create
    @diagnosis_pattern = Diagnosis::Pattern.new(diagnosis_pattern_params)

    respond_to do |format|
      if @diagnosis_pattern.save
        format.html { redirect_to @diagnosis_pattern, notice: 'Pattern was successfully created.' }
        format.json { render action: 'show', status: :created, location: @diagnosis_pattern }
      else
        format.html { render action: 'new' }
        format.json { render json: @diagnosis_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagnosis/patterns/1
  # PATCH/PUT /diagnosis/patterns/1.json
  def update
    respond_to do |format|
      if @diagnosis_pattern.update(diagnosis_pattern_params)
        format.html { redirect_to @diagnosis_pattern, notice: 'Pattern was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @diagnosis_pattern }
      else
        format.html { render action: 'edit' }
        format.json { render json: @diagnosis_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnosis/patterns/1
  # DELETE /diagnosis/patterns/1.json
  def destroy
    @diagnosis_pattern.destroy
    respond_to do |format|
      format.html { redirect_to diagnosis_patterns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagnosis_pattern
      @diagnosis_pattern = Diagnosis::Pattern.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diagnosis_pattern_params
      params.require(:diagnosis_pattern).permit(:name, :commentary, :citation_id, :tongue, :pulse, :slug, :canonical)
    end
end
