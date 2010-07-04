class PatternsController < ApplicationController
  # GET /patterns
  # GET /patterns.xml
  def index
    if params[:text] != nil
      @patterns = Pattern.find_by_textbook(params[:text])
    else
      @patterns = Pattern.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @patterns }
    end
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
  end

  # GET /patterns/1
  # GET /patterns/1.xml
  def show
    @pattern = Pattern.lookup(params)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pattern }
    end
  end

  # GET /patterns/new
  # GET /patterns/new.xml
  def new
    @pattern = Pattern.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pattern }
    end
  end

  # GET /patterns/1/edit
  def edit
    @pattern = Pattern.lookup(params)
  end

  # POST /patterns
  # POST /patterns.xml
  def create
    Pattern.transaction do
      respond_to do |format|
        begin
          @pattern = Pattern.new(params[:pattern])
          @pattern.save!
          flash[:notice] = 'Pattern was successfully created.'
          format.html { redirect_to(new_pattern_path) }
          format.xml  { render :xml => @pattern, :status => :created, :location => @pattern }
        rescue
          format.html { render :action => "new" }
          format.xml  { render :xml => @pattern.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /patterns/1
  # PUT /patterns/1.xml
  def update
    Pattern.transaction do
      respond_to do |format|
        begin
          @pattern = Pattern.find(params[:id])
          @pattern.update_attributes(params[:pattern])
          flash[:notice] = 'Pattern was successfully updated.'
          format.html { 
            if params[:commit] == "Update"
              @next_pattern = Pattern.where("id > #{@pattern.id}").order(:id).limit(1)[0]
              @next_pattern = @next_pattern ||= Pattern.first
              redirect_to(edit_pattern_path(@next_pattern))
            else
              redirect_to(@pattern) 
            end
          }
          format.xml  { head :ok }
        rescue
          format.html { render :action => "edit" }
          format.xml  { render :xml => @pattern.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /patterns/1
  # DELETE /patterns/1.xml
  def destroy
    @pattern = Pattern.find(params[:id])
    @pattern.destroy

    respond_to do |format|
      format.html { redirect_to(patterns_url) }
      format.xml  { head :ok }
    end
  end
end

