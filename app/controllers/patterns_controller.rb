class PatternsController < ApplicationController
  respond_to :html, :except=> [:cards]
  respond_to :json, :only => :index
  respond_to :prawn, :only => :cards

  def index
    @patterns = Pattern
    @patterns = @patterns.search(params[:term]) if params.has_key?(:term)
    @patterns = @patterns.from_text(params[:text]) if params.has_key?(:text)
    @patterns = @patterns.tagged_with(params[:tag], :on => get_context(params)) if params.has_key?(:tag)
    @patterns = @patterns.order_by_text

    @tags = @patterns.tag_counts_on(:tags)
    @primary_patterns = @patterns.tag_counts_on(:primary_patterns)
    @diseases = @patterns.tag_counts_on(:diseases)

    respond_with @patterns, @tags, @primary_patterns, @diseases do |format|
      format.json {render :json=> Pattern.to_autocomplete(@patterns)}
    end
  end
  def get_context(params)
    params[:context] ||= :tags
  end

  def cards
    @patterns = params.has_key?(:tags) ? Pattern.tagged_with(params[:tags].to_list) : Pattern.all
    @q = []
    @a = []

    while @patterns.size > 0
      newq=page
      newa=page
      (0..2).each do |r|
        (0..1).each do |c|
          if !(p = @patterns.shift).nil?
            newq[r][c] = p
            newa[r][1-c] = p
          end
        end
      end
      @q << newq
      @a << newa
    end
    respond_with @q, @a
  end

  # GET /patterns/1
  # GET /patterns/1.xml
  def show
    @pattern = Pattern.lookup(params)
    respond_with @pattern
  end

  # GET /patterns/new
  # GET /patterns/new.xml
  def new
    @pattern = Pattern.new
    respond_with @pattern
  end

  # GET /patterns/1/edit
  def edit
    @pattern = Pattern.lookup(params)
    respond_with @pattern
  end

  def create
    @pattern = Pattern.new(params[:pattern])
    flash[:notice] = "Successfully created pattern." if @pattern.save
    respond_with @pattern
  end

  def update
    @pattern = Pattern.find(params[:id])
    if @pattern.update_attributes(params[:pattern])
      flash[:notice] = "Successfully updated pattern of disharmony."
    end


    respond_with @pattern do |wants|
      if params[:commit] == "Update"
        @next_pattern = Pattern.where("id > #{@pattern.id}").order(:id).limit(1)[0]
        wants.html {redirect_to edit_pattern_path(@next_pattern ||= Pattern.first)}
      end
    end
  end

  def destroy
    @pattern = Pattern.find(params[:id])
    @pattern.destroy
    respond_with @pattern
  end
end

