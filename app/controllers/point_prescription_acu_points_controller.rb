class PointPrescriptionAcuPointsController < ApplicationController
  def create
    @point_prescription_acu_point = PointPrescriptionAcuPoint.create!(params[:point_prescription_acu_point])
    flash[:notice] = "Added an AcuPoint to the Point Prescription"
    respond_to do |format|
      format.js
    end
  end
end
