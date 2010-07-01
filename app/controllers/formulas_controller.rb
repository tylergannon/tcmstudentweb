class FormulasController < ApplicationController
  def index
    if params.has_key?(:tag_name)
      @formulas = Formula.tagged_with(params[:tag_name].to_list)
    else
      @formulas = Formula.search(params[:search])
    end

    @tags = Formula.tag_counts_on(:tags)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @formulas }
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
  end

  def tag_cloud
  end

  def categoryindex
    @category = FormulaCategory.find(params[:category_id])
    @formulas = Formula.find_all_by_formula_category_id(@category.id)
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
  end

  # GET /formulas/new
  # GET /formulas/new.xml
  def new
    @formula = Formula.new(:citation => Citation.new)
    @citation = Citation.new
    @source_text_citation = Citation.new
  end

  # GET /formulas/1/edit
  def edit
    @formula = Formula.lookup(params)
    @citation = @formula.citation ||= Citation.new
    @source_text_citation = @formula.source_text_citation ||= Citation.new
  end

  def create
    Formula.transaction do
      respond_to do |format|
        begin
          @formula = Formula.new(params[:formula])
          @formula.save!
          flash[:notice] = 'Formula was successfully created.'
          format.html { redirect_to(@formula) }
          format.xml  { render :xml => @formula, :status => :created, :location => @formula }
        rescue
          format.html { render :action => "new" }
          format.xml  { render :xml => @formula.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def update
    Formula.transaction do
      respond_to do |format|
        begin
          @formula = Formula.find(params[:id])
          @formula.update_attributes(params[:formula])
          flash[:notice] = 'Formula was successfully updated.'
          format.html { redirect_to(@formula) }
          format.xml  { head :ok }
        rescue
          format.html { render :action => "edit" }
          format.xml  { render :xml => @formula.errors, :status => :unprocessable_entity }
        end
      end
    end
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

    respond_to do |format|
      format.html { redirect_to(formulas_url) }
      format.xml  { head :ok }
    end
  end
end

