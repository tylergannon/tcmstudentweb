class References::AuthorsController < ApplicationController
  before_action :set_references_author, only: [:show, :edit, :update, :destroy]

  # GET /references/authors
  # GET /references/authors.json
  def index
    @references_authors = References::Author.all
  end

  # GET /references/authors/1
  # GET /references/authors/1.json
  def show
  end

  # GET /references/authors/new
  def new
    @references_author = References::Author.new
  end

  # GET /references/authors/1/edit
  def edit
  end

  # POST /references/authors
  # POST /references/authors.json
  def create
    @references_author = References::Author.new(references_author_params)

    respond_to do |format|
      if @references_author.save
        format.html { redirect_to @references_author, notice: 'Author was successfully created.' }
        format.json { render action: 'show', status: :created, location: @references_author }
      else
        format.html { render action: 'new' }
        format.json { render json: @references_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /references/authors/1
  # PATCH/PUT /references/authors/1.json
  def update
    respond_to do |format|
      if @references_author.update(references_author_params)
        format.html { redirect_to @references_author, notice: 'Author was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @references_author }
      else
        format.html { render action: 'edit' }
        format.json { render json: @references_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/authors/1
  # DELETE /references/authors/1.json
  def destroy
    @references_author.destroy
    respond_to do |format|
      format.html { redirect_to references_authors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_references_author
      @references_author = References::Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def references_author_params
      params.require(:references_author).permit(:name, :slug)
    end
end
