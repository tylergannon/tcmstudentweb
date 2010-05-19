class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.named_like(params[:search])
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @formulas }
    end
  end

  def show
    
  end
end
