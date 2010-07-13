class TherapeuticFunctionsController < ApplicationController
  respond_to :html
  respond_to :json, :only => :create

  def index
    @tf = TherapeuticFunction.search(params[:term])
    respond_with @tf do |format|
      format.json {render :json=> TherapeuticFunction.to_autocomplete(@tf)}
    end
  end

  def show
    @therapeutic_function = TherapeuticFunction.find(params[:id])
    respond_with @therapeutic_function
  end

  def new
    @therapeutic_function = TherapeuticFunction.new
    respond_with @therapeutic_function
  end

  def create
    @therapeutic_function = TherapeuticFunction.new(params[:therapeutic_function])
    @therapeutic_function.save
    respond_with @therapeutic_function
  end

  def edit
    @therapeutic_function = TherapeuticFunction.find(params[:id])
    respond_with @therapeutic_function
  end

  def update
    @therapeutic_function = TherapeuticFunction.find(params[:id])
    @therapeutic_function.update_attributes(params[:therapeutic_function])
    respond_with @therapeutic_function
  end

  def destroy
    @therapeutic_function = TherapeuticFunction.find(params[:id])
    @therapeutic_function.destroy
    respond_with @therapeutic_function
  end
end

