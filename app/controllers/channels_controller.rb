class ChannelsController < ApplicationController
  def index
		@channels = Channel.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
  
  def show
    @channel = Channel.find_by_name(params[:channel])
    @acu_points = @channel.acu_points
    
  end
end

