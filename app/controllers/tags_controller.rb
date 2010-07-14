class TagsController < ApplicationController
  respond_to :json, :only => :index

  def index
    @tags = ActsAsTaggableOn::Tag.named_like(params[:search])
     json = @tags.map{|t|
        {:value=>t.name}
      }.to_json
    respond_with @tags do |format|
      format.json {render :json=> json}
    end
  end
end

