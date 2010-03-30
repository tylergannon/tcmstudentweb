class SearchesController < ApplicationController
  def index
    search_params = params[:search].split(":")
    @objects = Object.const_get(search_params[0]).search(search_params[1])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
