class FormulasController < ApplicationController
  respond_to :html, :js
  has_scope :tagged_with, :as => :tag
  has_scope :by_category, :as => :category
  inherit_resources
  eager_loading_resource

  def index
    @categories = Formula.tag_counts_on(:formula_categories)
    @tags = Formula.tag_counts_on(:tags)

    index! do |format|
      def collection.each_category(&block)
        return unless self
        cats = self.tag_counts_on(:formula_categories)
        cats.each {|cat| block.call cat, self.tagged_with(cat, :on=>:formula_categories)}
      end
      format.json {render :json => resource_class.to_autocomplete(collection)}
    end
  end

  def collection
    @formulas ||= end_of_association_chain.order(:canonical )
  end

  def tag_cloud
  end

  def sort
    params[:formula_herb_children].each_with_index do |id, index|
      FormulaHerb.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

#  def cards
#    @formulas = Formula.tagged_with(params[:tags].to_list)
#    @q = []
#    @a = []

#    while @formulas.size > 0
#      newq=page
#      newa=page
#      (0..3).each do |r|
#        (0..2).each do |c|
#          if !(f = @formulas.shift).nil?
#            newq[r][c] = f.canonical
#            newa[r][2-c] = f
#          end
#        end
#      end
#      @q << newq
#      @a << newa
#    end
#    respond_with(@q, @a)
#  end
end

