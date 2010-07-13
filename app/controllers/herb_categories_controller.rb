class HerbCategoriesController < ApplicationController
  respond_to :html
  respond_to :json, :only=>:create

  def index
		@herb_categories = HerbCategory.search(:params[:term])
		respond_with(@herb_categories) do |format|
		  format.json {render :json=> HerbCategory.to_autocomplete(@herb_categories)}
		end
  end

  def show
    @herb_category = HerbCategory.find(params[:id])
    respond_with(@herb_category)
  end

  def new
    @herb_category = HerbCategory.new
    respond_with(@herb_category)
  end

  def create
    @herb_category = HerbCategory.new(params[:herb_category])
    flash[:notice] = "Successfully created herbcategory." if @herb_category.save
    respond_with(@herb_category)
  end

  def edit
    @herb_category = HerbCategory.find(params[:id])
    respond_with(@herb_category)
  end

  def update
    @herb_category = HerbCategory.find(params[:id])
    if @herb_category.update_attributes(params[:herb_category])
      flash[:notice] = "Successfully updated herbcategory."
    end
    respond_with(@herb_category)
  end

  def destroy
    @herb_category = HerbCategory.find(params[:id])
    flash[:notice] = "Successfully destroyed herbcategory." if     @herb_category.destroy
    respond_with(@herb_category)
  end
end

