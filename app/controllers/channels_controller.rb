class ChannelsController < ApplicationController
  respond_to :html, :js
  inherit_resources
  json_search

  def show
    @acu_points = AcuPoint.where(:channel_id=>@channel.id)
    @point_categories = AcuPointCategory.joins([{:acu_point=>:chaannel}]).where(:channels=>{:id=>@channel.id}).order("categories.id, acu_points.id")

    tags = TherapeuticFunction.by_channel(@channel.id).tag_counts_on(:tags)
    @tag_acu_points = {}
    # {<tag> => {<tf> =>{[<acu_point>, <acu_point>]}}}
    tags.each do |tag|
      contents = {}
      # For each tag, find the therapeutic functions and the associated acu_points.
      TherapeuticFunction.by_channel(@channel.id).tagged_with(tag.name).each do |tf|
        contents[tf] = AcuPoint.join_therapeutic_function.order("acu_points.id").where(:therapeutic_functions=>{:id=>tf.id}).where(:channel_id=>@channel.id).all
      end
      @tag_acu_points[tag] = contents

    end
    show!
  end
end

