class SymptomsController < ApplicationController
  respond_to :html
  respond_to :json, :only => :index

  def index
    @symptoms = Symptom.search(params[:term])
    respond_with @symptoms do |format|
      format.json {render :json=> Symptom.to_autocomplete(@symptoms)}
    end
  end


  def show
    @symptom = Symptom.lookup(params)
    respond_with @symptom
  end

  def new
    @symptom = Symptom.new
    respond_with @symptom
  end

  def create
    @symptom = Symptom.new(params[:symptom])
    @symptom.save
    respond_with @symptom
  end

  def edit
    @symptom = Symptom.find(params[:id])
    respond_with @symptom
  end

  def update
    @symptom = Symptom.find(params[:id])
    @symptom.update_attributes(params[:symptom])
    respond_with @symptom
  end

  def destroy
    @symptom = Symptom.find(params[:id])
    @symptom.destroy
    respond_with @symptom
  end
end

