class References::TextbooksController < ApplicationController
  before_action :set_references_textbook, only: [:show, :edit, :update, :destroy]

  # GET /references/textbooks
  # GET /references/textbooks.json
  def index
    @references_textbooks = References::Textbook.all
  end

  # GET /references/textbooks/1
  # GET /references/textbooks/1.json
  def show
  end

  # GET /references/textbooks/new
  def new
    @references_textbook = References::Textbook.new
  end

  # GET /references/textbooks/1/edit
  def edit
  end

  # POST /references/textbooks
  # POST /references/textbooks.json
  def create
    @references_textbook = References::Textbook.new(references_textbook_params)

    respond_to do |format|
      if @references_textbook.save
        format.html { redirect_to @references_textbook, notice: 'Textbook was successfully created.' }
        format.json { render action: 'show', status: :created, location: @references_textbook }
      else
        format.html { render action: 'new' }
        format.json { render json: @references_textbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /references/textbooks/1
  # PATCH/PUT /references/textbooks/1.json
  def update
    respond_to do |format|
      if @references_textbook.update(references_textbook_params)
        format.html { redirect_to @references_textbook, notice: 'Textbook was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @references_textbook }
      else
        format.html { render action: 'edit' }
        format.json { render json: @references_textbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/textbooks/1
  # DELETE /references/textbooks/1.json
  def destroy
    @references_textbook.destroy
    respond_to do |format|
      format.html { redirect_to references_textbooks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_references_textbook
      @references_textbook = References::Textbook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def references_textbook_params
      params.require(:references_textbook).permit(:author_id, :title, :slug, :year, :abbreviation)
    end
end
