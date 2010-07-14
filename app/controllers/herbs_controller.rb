class HerbsController < ApplicationController
  respond_to :html
  respond_to :json, :only => :index

  def index
    @herbs = Herb.search(params[:term])
    respond_with @herbs do |format|
      format.json {render :json=> Herb.to_autocomplete(@herbs)}
    end
  end


  # GET /herbs/1
  # GET /herbs/1.xml
  def show
    @herb = Herb.lookup(params)
    respond_with @herb
  end

  # GET /herbs/new
  # GET /herbs/new.xml
  def new
    @herb = Herb.new
    respond_with @herb
  end

  # GET /herbs/1/edit
  def edit
    @herb = Herb.lookup(params)
    respond_with @herb
  end

  def create
    @herb = Herb.new(params[:herb])
    flash[:notice] = 'Successfully created new Herb.' if @herb.save
    respond_with @herb
  end

  def update
    @herb = Herb.find(params[:id])
    flash[:notice] = 'Herb was successfully updated.' if @herb.update_attributes(params[:herb])
    respond_with @herb
  end

  # DELETE /herbs/1
  # DELETE /herbs/1.xml
  def destroy
    @herb = Herb.find(params[:id])
    @herb.destroy
    respond_with @herb
  end
end

