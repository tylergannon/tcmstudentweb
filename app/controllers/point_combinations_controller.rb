class PointCombinationsController < ApplicationController
  respond_to :js, :html
  inherit_resources
  before_filter :lookup_acu_point

  def create
    create!
    resource.acu_points << @acu_point if @acu_point
  end

  def update
    update!
    resource.acu_points << @acu_point if @acu_point
  end

  def lookup_acu_point
    @acu_point = AcuPoint.find(params[:acu_point_id]) if params[:acu_point_id]
  end
end

