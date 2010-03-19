class TongueQualitiesController < ApplicationController
  def index
    @tongue_qualities = TongueQuality.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    respond_to do |format|
    	format.html # index.html.erb
    	format.js   # index.js.erb
    	format.xml  { render :xml => @patterns }
    end
  end
end
