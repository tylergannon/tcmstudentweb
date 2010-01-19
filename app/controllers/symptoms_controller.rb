class SymptomsController < ApplicationController
  def index
    @symptoms = Symptom.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    respond_to do |format|
    	format.html # index.html.erb
    	format.js   # index.js.erb
    	format.xml  { render :xml => @patterns }
    end
  end
  
  def show
    @symptom = Symptom.find(params[:id])
  end
  
  def new
    @symptom = Symptom.new
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
