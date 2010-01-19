class HerbCategoriesController < ApplicationController
  def index
		@herb_categories = HerbCategory.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
		respond_to do |format|
			format.html # index.html.erb
			format.js   # index.js.erb
			format.xml  { render :xml => @patterns }
		end
  end
  
  def show
    @herb_category = HerbCategory.find(params[:id])
  end
  
  def new
    @herb_category = HerbCategory.new
  end
  
  def create
    @herb_category = HerbCategory.new(params[:herb_category])
    if @herb_category.save
      flash[:notice] = "Successfully created herbcategory."
      redirect_to @herb_category
    else
      render :action => 'new'
    end
  end
  
  def edit
    @herb_category = HerbCategory.find(params[:id])
  end
  
  def update
    @herb_category = HerbCategory.find(params[:id])
    if @herb_category.update_attributes(params[:herb_category])
      flash[:notice] = "Successfully updated herbcategory."
      redirect_to @herb_category
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @herb_category = HerbCategory.find(params[:id])
    @herb_category.destroy
    flash[:notice] = "Successfully destroyed herbcategory."
    redirect_to herb_categories_url
  end
end
