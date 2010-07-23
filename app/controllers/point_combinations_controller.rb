class PointCombinationsController < ApplicationController
  respond_to :js, :only=>[:create, :update]
  load_and_authorize_resource :only=>[:create, :update], :controller_resource => 'load_behind/controller_resource'
  your_basic_controller :respond_to => :js, :except=>[:index, :create, :update]

  def create
    flash[:notice] = "Successfully created new #{@point_combination.class.name.titleize}." if @point_combination.save
    @acu_point_id = @point_combination.acu_point_id
    respond_with @point_combination, @acu_point_id
  end

  def update
    flash[:notice] = "#{@point_combination.class.name.titleize} was successfully updated." if @point_combination.update_attributes(pc_params)
    @acu_point_id = @point_combination.acu_point_id
    respond_with @point_combination, @acu_point_id
  end
end

