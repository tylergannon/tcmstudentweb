class AcuPointInfosController < InheritedResources::Base
  respond_to :js, :html
  belongs_to :acu_point
end

