class References::CitationsController < ApplicationController
  before_action :set_references_citation, only: [:show, :edit, :update, :destroy]

  # GET /references/citations
  # GET /references/citations.json
  def index
    @references_citations = References::Citation.all
  end

  # GET /references/citations/1
  # GET /references/citations/1.json
  def show
  end

  # GET /references/citations/new
  def new
    @references_citation = References::Citation.new
  end

  # GET /references/citations/1/edit
  def edit
  end

  # POST /references/citations
  # POST /references/citations.json
  def create
    @references_citation = References::Citation.new(references_citation_params)

    respond_to do |format|
      if @references_citation.save
        format.html { redirect_to @references_citation, notice: 'Citation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @references_citation }
      else
        format.html { render action: 'new' }
        format.json { render json: @references_citation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /references/citations/1
  # PATCH/PUT /references/citations/1.json
  def update
    respond_to do |format|
      if @references_citation.update(references_citation_params)
        format.html { redirect_to @references_citation, notice: 'Citation was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @references_citation }
      else
        format.html { render action: 'edit' }
        format.json { render json: @references_citation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/citations/1
  # DELETE /references/citations/1.json
  def destroy
    @references_citation.destroy
    respond_to do |format|
      format.html { redirect_to references_citations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_references_citation
      @references_citation = References::Citation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def references_citation_params
      params.require(:references_citation).permit(:source_id, :location)
    end
end
