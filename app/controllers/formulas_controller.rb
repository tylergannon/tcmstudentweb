class FormulasController < ApplicationController
  prawnto :prawn => {
              :left_margin => 48,
              :right_margin => 48,
              :top_margin => 24,
              :bottom_margin => 24}
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

  def page
    [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
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
            newa[r][2-c] = {:ingredients=>f.herbs.map{|t| t.pinyin}, :symptoms =>[] }
            f.patterns.each do |p|
              newa[r][2-c][:symptoms] << p.symptoms.map{|t| t.name}
            end
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

    @formula = Formula.search(params[:id], :first)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @formula }
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
    @formula = Formula.search(params[:id], :first)
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
          @formula = Formula.search(params[:id], :first)
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

  def add_dui_yao
    @formula_dui_yao = FormulaDuiYao.new
    @formula_dui_yao.formula_id = params[:formula_id]
    @formula_dui_yao.dui_yao = DuiYao.find_or_create_by_herbs_pinyin(params[:formula_dui_yao][:herb1_pinyin], params[:formula_dui_yao][:herb2_pinyin])
    @formula_dui_yao.commentary = params[:formula_dui_yao][:commentary]
    respond_to do |format|
      if @formula.save
        flash[:notice] = 'Dui Yao was successfully added.'
        format.html { redirect_to(@formula) }
        format.xml  { render :xml => @formula, :status => :created, :location => @formula }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @formula.errors, :status => :unprocessable_entity }
      end
    end
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

