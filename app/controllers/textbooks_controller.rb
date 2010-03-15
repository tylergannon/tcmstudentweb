class TextbooksController < ApplicationController
  # GET /textbooks
  # GET /textbooks.xml
  def index
    search_param = "%#{params[:search]}%"
    @textbooks = Textbook.find(:all, :joins => 'LEFT OUTER JOIN authors ON authors.id = textbooks.author_id',
                               :conditions => ["title LIKE ? OR authors.name LIKE ?",
                                               search_param, search_param])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @textbooks }
    end
  end

  # GET /textbooks/1
  # GET /textbooks/1.xml
  def show
    @textbook = Textbook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @textbook }
    end
  end

  # GET /textbooks/new
  # GET /textbooks/new.xml
  def new
    @textbook = Textbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @textbook }
    end
  end

  # GET /textbooks/1/edit
  def edit
    @textbook = Textbook.find(params[:id])
  end

  # POST /textbooks
  # POST /textbooks.xml
  def create
    @textbook = Textbook.new(params[:textbook])

    respond_to do |format|
      if @textbook.save
        flash[:notice] = 'Textbook was successfully created.'
        format.html { redirect_to(@textbook) }
        format.xml  { render :xml => @textbook, :status => :created, :location => @textbook }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @textbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /textbooks/1
  # PUT /textbooks/1.xml
  def update
    @textbook = Textbook.find(params[:id])

    respond_to do |format|
      if @textbook.update_attributes(params[:textbook])
        flash[:notice] = 'Textbook was successfully updated.'
        format.html { redirect_to(@textbook) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @textbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /textbooks/1
  # DELETE /textbooks/1.xml
  def destroy
    @textbook = Textbook.find(params[:id])
    @textbook.destroy

    respond_to do |format|
      format.html { redirect_to(textbooks_url) }
      format.xml  { head :ok }
    end
  end
end
