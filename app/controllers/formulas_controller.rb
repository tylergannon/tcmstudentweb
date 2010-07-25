class FormulasController < ApplicationController
  respond_to :html, :js
  inherit_resources
  json_search
  has_scope :tagged_with, :as => :tag_name


  def index
    index! do |format|
      format.json {render :json => resource_class.to_autocomplete(collection)}
      format.html {
        @categories = collection.tag_counts_on(:formula_categories)
        @formulas_by_cat={}
        @categories.each do |cat_tag|
          @formulas_by_cat[cat_tag.name] = collection.tagged_with cat_tag.name, :on=>:formula_categories
        end

        @tags = collection.tag_counts_on(:tags)
      }
    end
  end

  def collection
    @collection ||= end_of_association_chain.order(:canonical)
  end

  def tag_cloud
  end

  # GET /formulas/1
  # GET /formulas/1.xml
  def show
    show! do |format|
      format.html {
        if (@taglist = params[:tags]).nil?
          @next = Formula.next_from(resource).first
        else
          @next = Formula.next_from(resource).tagged_with(@taglist.to_list).first
        end
      }
    end
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

