class PulseQualitiesController < ApplicationController
  def index
		@pulse_qualities = PulseQuality.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
		respond_to do |format|
			format.html # index.html.erb
			format.js   # index.js.erb
			format.xml  { render :xml => @patterns }
		end
  end
  
  def show
    @pulse_quality = PulseQuality.find(params[:id])
  end
  
  def new
    @pulse_quality = PulseQuality.new
  end
  
  def create
    @pulse_quality = PulseQuality.new(params[:pulse_quality])
    if @pulse_quality.save
      flash[:notice] = "Successfully created pulsequality."
      redirect_to @pulse_quality
    else
      render :action => 'new'
    end
  end
  
  def edit
    @pulse_quality = PulseQuality.find(params[:id])
  end
  
  def update
    @pulse_quality = PulseQuality.find(params[:id])
    if @pulse_quality.update_attributes(params[:pulse_quality])
      flash[:notice] = "Successfully updated pulsequality."
      redirect_to @pulse_quality
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @pulse_quality = PulseQuality.find(params[:id])
    @pulse_quality.destroy
    flash[:notice] = "Successfully destroyed pulsequality."
    redirect_to pulse_qualities_url
  end
end
