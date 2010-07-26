class PointCombinationsController < ApplicationController
  respond_to :js, :html
  inherit_resources
  has_scope :by_acu_point, :as => :acu_point_id
  has_scope :by_symptom, :as => :symptom_id
  has_instance_variable :acu_point

  def create
    create!
    resource.acu_points << @acu_point if @acu_point
  end

  def update
    update!
    resource.acu_points << @acu_point if @acu_point
  end
end

