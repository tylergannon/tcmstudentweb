class CategoriesController < ApplicationController
  respond_to :json, :only => :index

  def index
    @categories = Category.search(params[:term])
    respond_with @categories do |format|
      format.json {render :json=> Category.to_autocomplete(@categories)}
    end
  end
end

