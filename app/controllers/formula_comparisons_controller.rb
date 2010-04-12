class FormulaComparisonsController < ApplicationController
  def index
    @formula_comparisons = FormulaComparison.all
  end
end
