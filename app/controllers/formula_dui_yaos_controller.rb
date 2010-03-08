class FormulaDuiYaosController < ApplicationController
  def create
		@formula_dui_yao = FormulaDuiYao.new
		dui_yao_params = params[:formula_dui_yao]
		@formula_dui_yao.formula_id = dui_yao_params[:formula_id]
		@formula = Formula.find(dui_yao_params[:formula_id])
		@formula_dui_yao.dui_yao = DuiYao.find_or_create_by_herbs_pinyin(dui_yao_params[:herb1_pinyin],dui_yao_params[:herb2_pinyin])
		@formula_dui_yao.commentary = dui_yao_params[:commentary]

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
				end
			end
    end
  end
end
