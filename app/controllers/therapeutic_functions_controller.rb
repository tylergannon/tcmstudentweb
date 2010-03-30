class TherapeuticFunctionsController < ApplicationController
  def index
    @therapeutic_functions = TherapeuticFunction.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search].downcase}%"])
    respond_to do |format|
    	format.html # index.html.erb
    	format.js   # index.js.erb
    	format.xml  { render :xml => @patterns }
    end
  end

  def show
    @therapeutic_function = TherapeuticFunction.find(params[:id])
  end

  def new
    @therapeutic_function = TherapeuticFunction.new
  end

  def create
    @therapeutic_function = TherapeuticFunction.new(params[:therapeutic_function])
    if @therapeutic_function.save
      flash[:notice] = "Successfully created therapeuticfunction."
      redirect_to @therapeutic_function
    else
      render :action => 'new'
    end
  end

  def edit
    @therapeutic_function = TherapeuticFunction.find(params[:id])
  end

  def update
    @therapeutic_function = TherapeuticFunction.find(params[:id])
    if @therapeutic_function.update_attributes(params[:therapeutic_function])
      flash[:notice] = "Successfully updated therapeuticfunction."
      redirect_to @therapeutic_function
    else
      render :action => 'edit'
    end
  end

  def destroy
    @therapeutic_function = TherapeuticFunction.find(params[:id])
    @therapeutic_function.destroy
    flash[:notice] = "Successfully destroyed therapeuticfunction."
    redirect_to therapeutic_functions_url
  end
end
