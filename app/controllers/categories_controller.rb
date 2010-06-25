class CategoriesController < ApplicationController
  def index
    @categories = Category.where("name like '#{params[:search]}%'")
  end

end

