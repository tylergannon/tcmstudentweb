class ContraindicationsController < ApplicationController
  respond_to :html, :json
  def index
    @contraindications = Contraindication.search(params[:term])
    respond_with @contraindications do |format|
      format.json {render :json=> Contraindication.to_autocomplete(@contraindications)}
    end
  end
end

