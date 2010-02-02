class FormulaDuiYaosController < ApplicationController
	
	
  def new
		@formula_dui_yao = FormulaDuiYao.new
  end

  def edit
		@formula_dui_yao = FormulaDuiYao.find(params[:id])
		respond_to do |format|
			format.html
			format.js
		end
  end

  def create
		@formula_dui_yao = FormulaDuiYao.new
		myParams = params[:formula_dui_yao]
		@formula_dui_yao.formula_id = myParams[:formula_id]
		@formula = Formula.find(myParams[:formula_id])
		@formula_dui_yao.dui_yao = DuiYao.find_or_create_by_herbs_pinyin(myParams[:herb1_pinyin],myParams[:herb2_pinyin])
		@formula_dui_yao.commentary = myParams[:commentary]
		
    respond_to do |format|
			if @formula.formula_dui_yaos.select{|a| a.dui_yao_id == @formula_dui_yao.dui_yao.id}.size > 0
				flash[:notice] = 'This Dui Yao is already associated with the formula.'
				format.html { redirect_to(@formula) }
				format.js
			else
				if @formula_dui_yao.save
					flash[:dui_yao] = 'Dui Yao was successfully added.'
					format.html { redirect_to(@formula) }
					format.js
					
				else
					format.html { render :action => "new" }
					format.xml  { render :xml => @formula.errors, :status => :unprocessable_entity }
				end				
			end

    end
  end

  def update
  end

  def destroy
  end

end
