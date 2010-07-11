class ChannelsController < ApplicationController
  def index
		@channels = Channel.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
  
  def show
    @channel = Channel.lookup(params)
    @acu_points = AcuPoint.where(:channel_id=>@channel.id)

    tags = TherapeuticFunction.by_channel(@channel.id).tag_counts_on(:tags)
    @tag_acu_points = {}
    # {<tag> => {<tf> =>{[<acu_point>, <acu_point>]}}}
    tags.each do |tag|
      contents = {}
      # For each tag, find the therapeutic functions and the associated acu_points.
      TherapeuticFunction.by_channel(@channel.id).tagged_with(tag.name).each do |tf|
        contents[tf] = AcuPoint.join_therapeutic_function.where(:therapeutic_functions=>{:id=>tf.id}).where(:channel_id=>@channel.id).all
      end
      @tag_acu_points[tag] = contents
      
    end
    logger.error @tag_acu_points.inspect
  end
end

