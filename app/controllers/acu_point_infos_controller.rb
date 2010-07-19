class AcuPointInfosController < ApplicationController
  respond_to :js

  def new
    @acu_point_info = AcuPointInfo.create(:acu_point_id=>params[:acu_point_id])
  end

  def show
    @acu_point_info = AcuPointInfo.lookup(params)
    respond_with @acu_point_info
  end

  def edit
    @acu_point_info = AcuPointInfo.lookup(params)
    respond_with @acu_point_info
  end

  def create
    @acu_point_info = AcuPointInfo.new(params[:acu_point_info])
    flash[:notice] = "Successfully created new #{@acu_point_info.class.name.titleize}." if @acu_point_info.save
    respond_with @acu_point_info
  end

  def update
    @acu_point_info = AcuPointInfo.find(params[:id])
    flash[:notice] = "#{@acu_point_info.class.name.titleize} was successfully updated." if @acu_point_info.update_attributes(params[:acu_point_info])
    respond_with @acu_point_info
  end

  def destroy
    @acu_point_info = AcuPointInfo.lookup(params)
    @acu_point_info.destroy
    respond_with @acu_point_info
  end
end

