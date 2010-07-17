class AcuPointCategoriesController < ApplicationController
  respond_to :js, :html

  def new
    acu_point_id = params[:acu_point_id]

    @acu_point_category = AcuPointCategory.new(:acu_point_id=>acu_point_id)
    respond_with @acu_point_category
  end

  def show
    @acu_point_category = AcuPointCategory.lookup(params)
    respond_with @acu_point_category
  end

  def edit
    @acu_point_category = AcuPointCategory.lookup(params)
    respond_with @acu_point_category
  end

  def create
    @acu_point_category = AcuPointCategory.new(params[:acu_point_category])
    flash[:notice] = "Successfully created new #{@acu_point_category.class.name.titleize}." if @acu_point_category.save
    respond_with @acu_point_category
  end

  def update
    @acu_point_category = AcuPointCategory.find(params[:id])
    flash[:notice] = "#{@acu_point_category.class.name.titleize} was successfully updated." if @acu_point_category.update_attributes(params[:acu_point_category])
    respond_with @acu_point_category
  end

  def destroy
    @acu_point_category = AcuPointCategory.lookup(params)
    @acu_point_category.destroy
    respond_with @acu_point_category
  end


end

