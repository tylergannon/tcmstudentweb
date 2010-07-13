class AcuPointsController < ApplicationController
  respond_to :html

  def index
    @acu_points = AcuPoint.all
    respond_with @acu_points
  end

  def show
    @acu_point = AcuPoint.lookup(params)
    respond_with @acu_point
  end

  def new
    @acu_point = AcuPoint.new
    respond_with @acu_point
  end

  def edit
    @acu_point = AcuPoint.lookup(params)
  end

  def create
    @acu_point = AcuPoint.new(params[:acu_point])
    flash[:notice] = 'Acu Point was successfully created.' if @acu_point.save
    respond_with(@acu_point)
  end

  def update
    @acu_point = AcuPoint.lookup(params)
    flash[:notice] = 'Acu Point was successfully updated.' if @acu_point.update_attributes(params[:acu_point])
    respond_with @acu_point
  end


  # DELETE /acu_points/1
  # DELETE /acu_points/1.xml
  def destroy
    @acu_point = AcuPoint.lookup(params)
    @acu_point.destroy
    respond_with @acu_point
  end
end

