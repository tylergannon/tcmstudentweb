class PointPrescriptionsController < ApplicationController
  respond_to :html, :js
  has_scope :by_acu_point, :as => :acu_point_id
  has_scope :by_pattern, :as => :pattern_id
  has_instance_variable :acu_point
  before_filter :lookup_acu_point
  inherit_resources
  eager_loading_collection
end

