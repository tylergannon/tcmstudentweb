class FormulasController < ApplicationController
  load_and_authorize_resource
  def index
    @formulas = Formula.find(:all, :conditions => ['canonical LIKE ?', "%#{params[:search]}%"])

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @formulas }
    end
  end

  def categoryindex
    @category = FormulaCategory.find(params[:category_id])
    @formulas = Formula.find_all_by_formula_category_id(@category.id)
  end

  # GET /formulas/1
  # GET /formulas/1.xml
  def show
    @formula = Formula.find(params[:id])

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
    @formula = Formula.find(params[:id])
    @citation = @formula.citation ||= Citation.new
    @source_text_citation = @formula.source_text_citation ||= Citation.new
  end



  # POST /formulas
  # POST /formulas.xml
  def create
    @formula = Formula.new(params[:formula])
    write_symptoms_and_therapeutic_functions_to_params_hash

      if @formula.save
        flash[:notice] = 'Formula was successfully created.'
        redirect_to(@formula)
      else
        s = ""
        @formula.errors.each_full {|msg| s += "<br />#{msg}"}
        flash[:notice] = s

        render :action => "new"
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

  # PUT /formulas/1
  # PUT /formulas/1.xml
  def update
    @formula = Formula.find(params[:id])
    write_symptoms_and_therapeutic_functions_to_params_hash
    respond_to do |format|
      if @formula.update_attributes(params[:formula])
        flash[:notice] = 'Formula was successfully updated.'
        format.html { redirect_to(@formula) }
        format.xml  { head :ok }
      else
        format.html {
          render :action => "edit"
          s = ""
          @formula.errors.each_full {|msg| s += "<br />#{msg}"}
          flash[:notice] = s
        }
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

  def write_symptoms_and_therapeutic_functions_to_params_hash
    symptoms_text = params[:extra][:symptoms]
    unless symptoms_text.empty?
      bullshit = FormParser.parse_symptoms(symptoms_text, FormulaSymptom)
      @formula.attributes = {"formula_symptoms_attributes" =>
              bullshit.write_attributes(@formula.formula_symptoms)}
    end

    tp_text = params[:extra][:therapeutic_functions]
    unless tp_text.empty?
      @formula.attributes = {"formula_therapeutic_functions_attributes" =>
              FormParser.parse_therapeutic_functions(tp_text, FormulaTherapeuticFunction).write_attributes(@formula.formula_therapeutic_functions)}
    end
  end

end

