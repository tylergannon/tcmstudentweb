class ChannelsController < ApplicationController
  respond_to :html, :js
  inherit_resources
  json_search

  INCLUDE_ALL = [{
            :acu_points=>{
              :acu_point_infos=>[
                :symptoms,
                { :therapeutic_functions => :tags,
                  :acu_point_therapeutic_functions=>[
                    {:therapeutic_function=>:tags},
                    :symptoms
                    ],
                  :acu_point_symptoms=>:symptom
                }
              ]
            }
          }]

  def resource
    if params[:action] == :show
      @channel ||= Channel.find(params[:id],:include=>INCLUDE_ALL)
    else
      super
    end

    authorize! @channel, params[:action] unless @authorized
    @authorized = true
    @channel
  end
end

