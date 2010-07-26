class AcuPointsController < ApplicationController
  respond_to :js, :html
  inherit_resources

  def index
    @channels = Channel.all

    index! do |format|
      def collection.each_category(&block)
        return unless self
        cats = self.tag_counts_on(:formula_categories)
        cats.each {|cat| block.call cat, self.tagged_with(cat, :on=>:formula_categories)}
      end
      format.json {render :json => resource_class.to_autocomplete(collection)}
    end
  end

end

