class HerbsController < ApplicationController
  # GET /herbs
  # GET /herbs.xml
  def index
		@herbs = Herb.search(params[:search])
		respond_to do |format|
			format.html # index.html.erb
			format.js   # index.js.erb
			format.xml  { render :xml => @patterns }
		end
  end

  # GET /herbs/1
  # GET /herbs/1.xml
  def show
    @herb = Herb.lookup(params)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @herb }
    end
  end

  # GET /herbs/new
  # GET /herbs/new.xml
  def new
    @herb = Herb.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @herb }
    end
  end

  # GET /herbs/1/edit
  def edit
    @herb = Herb.lookup(params)
  end

  # POST /herbs
  # POST /herbs.xml
  def create
    @herb = Herb.new(params[:herb])

    respond_to do |format|
      if @herb.save
        flash[:notice] = 'Herb was successfully created.'
        format.html { redirect_to(@herb) }
        format.xml  { render :xml => @herb, :status => :created, :location => @herb }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @herb.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @herb = Herb.find(params[:id])

    respond_to do |format|
      if @herb.update_attributes(params[:herb])
        flash[:notice] = 'Herb was successfully updated.'
        format.html { redirect_to(@herb) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @herb.errors, :status => :unprocessable_entity }
      end
    end
  end


	def update_herb
		if @herb.update_attributes(params[:herb])
			flash[:notice] = 'Herb was successfully updated.'
			redirect_to(@herb)
		else
			render :action => "edit"

		end
	end

  # DELETE /herbs/1
  # DELETE /herbs/1.xml
  def destroy
    @herb = Herb.find(params[:id])
    @herb.destroy

    respond_to do |format|
      format.html { redirect_to(herbs_url) }
      format.xml  { head :ok }
    end
  end
end
