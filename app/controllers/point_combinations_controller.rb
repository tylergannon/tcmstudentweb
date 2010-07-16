class PointCombinationsController < ApplicationController
  respond_to :js

  def index
    @point_combinations = PointCombination.all
    respond_with @point_combination
  end

  def new
    @point_combination = PointCombination.new
    @acu_point_id = params[:acu_point_id]
    respond_with @point_combination, @acu_point_id
  end

  def show
    @point_combination = PointCombination.lookup(params)
    @acu_point_id = params[:acu_point_id] unless @acu_point
    respond_with @point_combination, @acu_point_id
  end

  def edit
    @point_combination = PointCombination.lookup(params)
    @acu_point_id = params[:acu_point_id]
    respond_with @point_combination, @acu_point_id
  end

  def create
    @acu_point_id = params[:point_combination]["acu_point_id"]
    pc_params = params[:point_combination].reject_keys(["acu_point_id"])
    @point_combination = PointCombination.new(pc_params)
    unless @point_combination.acu_points.include_where{|t| t.id==@acu_point_id}
      @point_combination.acu_points << AcuPoint.find(@acu_point_id)
    end
    flash[:notice] = "Successfully created new #{@point_combination.class.name.titleize}." if @point_combination.save
    respond_with @point_combination, @acu_point_id
  end

  def update
    @point_combination = PointCombination.find(params[:id])
    @acu_point_id = params[:point_combination]["acu_point_id"]
    pc_params = params[:point_combination].reject_keys(["acu_point_id"])
    unless @point_combination.acu_points.include_where{|t| t.id==@acu_point_id}
      @point_combination.acu_points << AcuPoint.find(@acu_point_id)
    end
    flash[:notice] = "#{@point_combination.class.name.titleize} was successfully updated." if @point_combination.update_attributes(pc_params)
    respond_with @point_combination, @acu_point_id
  end
end

