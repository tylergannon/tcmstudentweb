class AcuPointTherapeuticFunctionsController < ApplicationController
  respond_to :js, :html
  inherit_resources
  has_instance_variable :acu_point_info, :only=>:new, :for_resource=>true
end

