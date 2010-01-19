class TongueQualitiesController < ApplicationController
  def index
    @tongue_qualities = TongueQuality.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    respond_to do |format|
    	format.html # index.html.erb
    	format.js   # index.js.erb
    	format.xml  { render :xml => @patterns }
    end
  end
  
  def show
    @tongue_quality = TongueQuality.find(params[:id])
  end
  
  def new
    @tongue_quality = TongueQuality.new
  end
  
  def create
    @tongue_quality = TongueQuality.new(params[:tongue_quality])
    if @tongue_quality.save
      flash[:notice] = "Successfully created tonguequality."
      redirect_to @tongue_quality
    else
      render :action => 'new'
    end
  end
  
  def edit
    @tongue_quality = TongueQuality.find(params[:id])
  end
  
  def update
    @tongue_quality = TongueQuality.find(params[:id])
    if @tongue_quality.update_attributes(params[:tongue_quality])
      flash[:notice] = "Successfully updated tonguequality."
      redirect_to @tongue_quality
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @tongue_quality = TongueQuality.find(params[:id])
    @tongue_quality.destroy
    flash[:notice] = "Successfully destroyed tonguequality."
    redirect_to tongue_qualities_url
  end
end
