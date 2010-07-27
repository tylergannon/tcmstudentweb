class ChannelsController < ApplicationController
  respond_to :html, :js
  inherit_resources
  json_search

  def resource
    if params[:action] == :show
      @channel ||= Channel.find(params[:id],
        :include=>[{:acu_points=>{:acu_point_infos=>{
          :acu_point_therapeutic_functions=>:therapeutic_function,
          :acu_point_symptoms=>:symptom
          }}}])
    else
      super
    end

    authorize! @channel, params[:action] unless @authorized
    @authorized = true
    @channel
  end
end

