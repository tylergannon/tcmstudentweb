class SymptomsController < ApplicationController
  respond_to :html, :js
  def index
    @symptoms = Symptom.search(params[:search])
    respond_with @symptoms

  end

  def show
    @symptom = Symptom.find(params[:id])
    respond_with @symptom
  end

  def new
    @symptom = Symptom.new
    respond_with @symptom
  end

  def create
    @symptom = Symptom.new(params[:symptom])
    if @symptom.save
      flash[:notice] = "Successfully created symptom."
      redirect_to @symptom
    else
      render :action => 'new'
    end
  end

  def edit
    @symptom = Symptom.find(params[:id])
    respond_with @symptom
  end

  def update
    @symptom = Symptom.find(params[:id])
    if @symptom.update_attributes(params[:symptom])
      flash[:notice] = "Successfully updated symptom."
      redirect_to @symptom
    else
      render :action => 'edit'
    end
  end

  def destroy
    @symptom = Symptom.find(params[:id])
    @symptom.destroy
    flash[:notice] = "Successfully destroyed symptom."
    redirect_to symptoms_url
  end
end
