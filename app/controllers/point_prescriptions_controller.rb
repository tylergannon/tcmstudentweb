class PointPrescriptionsController < ApplicationController
  respond_to :html, :js
  has_scope :by_acu_point, :as => :acu_point_id
  has_scope :by_pattern, :as => :pattern_id
  before_filter :lookup_acu_point
  inherit_resources

  def lookup_acu_point
    @acu_point = AcuPoint.find(params[:acu_point_id]) if params[:acu_point_id]
  end
end

