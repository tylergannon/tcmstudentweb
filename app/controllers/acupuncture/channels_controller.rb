class Acupuncture::ChannelsController < ApplicationController
  before_action :set_acupuncture_channel, only: [:show, :edit, :update, :destroy]

  # GET /acupuncture/channels
  # GET /acupuncture/channels.json
  def index
    @acupuncture_channels = Acupuncture::Channel.all
  end

  # GET /acupuncture/channels/1
  # GET /acupuncture/channels/1.json
  def show
  end

  # GET /acupuncture/channels/new
  def new
    @acupuncture_channel = Acupuncture::Channel.new
  end

  # GET /acupuncture/channels/1/edit
  def edit
  end

  # POST /acupuncture/channels
  # POST /acupuncture/channels.json
  def create
    @acupuncture_channel = Acupuncture::Channel.new(acupuncture_channel_params)

    respond_to do |format|
      if @acupuncture_channel.save
        format.html { redirect_to @acupuncture_channel, notice: 'Channel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @acupuncture_channel }
      else
        format.html { render action: 'new' }
        format.json { render json: @acupuncture_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acupuncture/channels/1
  # PATCH/PUT /acupuncture/channels/1.json
  def update
    respond_to do |format|
      if @acupuncture_channel.update(acupuncture_channel_params)
        format.html { redirect_to @acupuncture_channel, notice: 'Channel was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @acupuncture_channel }
      else
        format.html { render action: 'edit' }
        format.json { render json: @acupuncture_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acupuncture/channels/1
  # DELETE /acupuncture/channels/1.json
  def destroy
    @acupuncture_channel.destroy
    respond_to do |format|
      format.html { redirect_to acupuncture_channels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acupuncture_channel
      @acupuncture_channel = Acupuncture::Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acupuncture_channel_params
      params.require(:acupuncture_channel).permit(:name, :abbreviation)
    end
end
