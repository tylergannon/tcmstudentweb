class SearchController < ApplicationController
  def index
    search_params = params[:search].split(":")
    [[AcuPoint:ub-1]]

    @doo = Nice.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])

  end
end
