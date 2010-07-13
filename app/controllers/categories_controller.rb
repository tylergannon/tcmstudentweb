class CategoriesController < ApplicationController
  def index
    @categories = Category.search(params[:name])
  end
end

