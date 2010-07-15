class PointCombinationsController < ApplicationController
  respond_to :js

  def index
    @point_combinations = PointCombination.all
    respond_with @point_combination
  end

  def new
    @point_combination = PointCombination.new
    respond_with @point_combination
  end

  def show
    @point_combination = PointCombination.lookup(params)
    respond_with @point_combination
  end

  def edit
    @point_combination = PointCombination.lookup(params)
    respond_with @point_combination
  end

  def create
    @point_combination = PointCombination.new(params[:point_combination])
    flash[:notice] = "Successfully created new #{@point_combination.class.name.titleize}." if @point_combination.save
    respond_with @point_combination
  end

  def update
    @point_combination = PointCombination.find(params[:id])
    flash[:notice] = "#{@point_combination.class.name.titleize} was successfully updated." if @point_combination.update_attributes(params[:point_combination])
    respond_with @point_combination
  end

  def destroy
    @point_combination = PointCombination.lookup(params)
    @point_combination.destroy
    respond_with @point_combination
  end
end

