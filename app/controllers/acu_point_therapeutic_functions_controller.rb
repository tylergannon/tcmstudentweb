class AcuPointTherapeuticFunctionsController < ApplicationController
  respond_to :js

  def new
    @acu_point_therapeutic_function = AcuPointTherapeuticFunction.new(:acu_point_info_id=>params[:acu_point_info_id])
    respond_with @acu_point_therapeutic_function
  end

  def show
    @acu_point_therapeutic_function = AcuPointTherapeuticFunction.lookup(params)
    respond_with @acu_point_therapeutic_function
  end

  def edit
    @acu_point_therapeutic_function = AcuPointTherapeuticFunction.lookup(params)
    respond_with @acu_point_therapeutic_function
  end

  def create
    @acu_point_therapeutic_function = AcuPointTherapeuticFunction.new(params[:acu_point_therapeutic_function])
    flash[:notice] = "Successfully created new #{@acu_point_therapeutic_function.class.name.titleize}." if @acu_point_therapeutic_function.save
    respond_with @acu_point_therapeutic_function
  end

  def update
    @acu_point_therapeutic_function = AcuPointTherapeuticFunction.find(params[:id])
    flash[:notice] = "#{@acu_point_therapeutic_function.class.name.titleize} was successfully updated." if @acu_point_therapeutic_function.update_attributes(params[:acu_point_therapeutic_function])
    respond_with @acu_point_therapeutic_function
  end

  def destroy
    @acu_point_therapeutic_function = AcuPointTherapeuticFunction.lookup(params)
    @acu_point_therapeutic_function.destroy
    respond_with @acu_point_therapeutic_function
  end
end

