class TagsController < ApplicationController
  respond_to :json, :only => :index

  def index
    @tags = ActsAsTaggableOn::Tag.named_like(params[:search])
      .map{|t|
        {:value=>t.name}
      }.to_json

    respond_with @tags
  end
end

