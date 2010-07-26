class AcuPointInfosController < ApplicationController
  respond_to :js, :html
  inherit_resources
  has_instance_variable :acu_point, :only=>:new, :for_resource=>true

  def new
    new! do |format|
      resource.acu_point = @acu_point
    end
  end
end

