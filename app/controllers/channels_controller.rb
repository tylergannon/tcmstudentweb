class ChannelsController < ApplicationController
  def index
		@channels = Channel.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
end

