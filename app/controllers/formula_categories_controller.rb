class FormulaCategoriesController < ApplicationController
  def index
		@formulas = Formula.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
		respond_to do |format|
			format.html # index.html.erb
			format.js   # index.js.erb
			format.xml  { render :xml => @patterns }
		end
  end
  
  def show
    @formula_category = FormulaCategory.find(params[:id])
  end
  
  def new
    @formula_category = FormulaCategory.new
  end
  
  def create
    @formula_category = FormulaCategory.new(params[:formula_category])
    if @formula_category.save
      flash[:notice] = "Successfully created formulacategory."
      redirect_to @formula_category
    else
      render :action => 'new'
    end
  end
  
  def edit
    @formula_category = FormulaCategory.find(params[:id])
  end
  
  def update
    @formula_category = FormulaCategory.find(params[:id])
    if @formula_category.update_attributes(params[:formula_category])
      flash[:notice] = "Successfully updated formulacategory."
      redirect_to @formula_category
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @formula_category = FormulaCategory.find(params[:id])
    @formula_category.destroy
    flash[:notice] = "Successfully destroyed formulacategory."
    redirect_to formula_categories_url
  end
end
