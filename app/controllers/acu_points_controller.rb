class AcuPointsController < InheritedResources::Base
  respond_to :js, :html
  optional_belongs_to :channel
  has_scope :tf_tagged_with, :as => :tags
  eager_loading_collection
  eager_loading_resource

  def index
    index! do |format|
      def collection.each_tag
      format.json {render :json => resource_class.to_autocomplete(collection)}
    end
  end
end

