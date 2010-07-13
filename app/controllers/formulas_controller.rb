class FormulasController < ApplicationController
  respond_to :html, :except => [:cards]
  respond_to :prawn, :only=>:cards
  respond_to :json, :only=>:index

  def index
    if params.has_key?(:tag_name)
      @formulas = Formula.tagged_with(params[:tag_name].to_list)
    else
      @formulas = Formula.search(params[:term])
    end

    @tags = Formula.tag_counts_on(:tags)
    respond_with(@formulas, @tags) do |format|
      format.json { render :json => Formula.to_autocomplete(@formulas) }
    end
  end

  def cards
    @formulas = Formula.tagged_with(params[:tags].to_list)
    @q = []
    @a = []

    while @formulas.size > 0
      newq=page
      newa=page
      (0..3).each do |r|
        (0..2).each do |c|
          if !(f = @formulas.shift).nil?
            newq[r][c] = f.canonical
            newa[r][2-c] = f
          end
        end
      end
      @q << newq
      @a << newa
    end
    respond_with(@q, @a)
  end

  def tag_cloud
  end

  # GET /formulas/1
  # GET /formulas/1.xml
  def show
    @formula = Formula.lookup(params)
    if (@taglist = params[:tags]).nil?
      @next = Formula.next_from(@formula)[0]
    else
      @next = Formula.next_from(@formula).tagged_with(@taglist.to_list)[0]
    end
    respond_with(@formula, @next)
  end

  # GET /formulas/new
  # GET /formulas/new.xml
  def new
    @formula = Formula.new(:citation => Citation.new)
    respond_with(@formula)
  end

  # GET /formulas/1/edit
  def edit
    @formula = Formula.lookup(params)
    @citation = @formula.citation ||= Citation.new
    @source_text_citation = @formula.source_text_citation ||= Citation.new
    respond_with(@formula)
  end

  def create
    @formula = Formula.new(params[:formula])
    @formula.save
    respond_with @formula
  end

  def update
    @formula = Formula.find(params[:id])
    @formula.update_attributes(params[:formula])
    respond_with @formula
  end

  def sort
    params[:formula_herb_children].each_with_index do |id, index|
      FormulaHerb.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  # DELETE /formulas/1
  # DELETE /formulas/1.xml
  def destroy
    @formula = Formula.find(params[:id])
    @formula.destroy
    respond_with @formula
  end
end

