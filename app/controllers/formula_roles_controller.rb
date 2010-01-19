class FormulaRoleController < ApplicationController
  def index
		@formula_roles = FormulaRole.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
end

