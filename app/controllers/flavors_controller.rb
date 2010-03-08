class FlavorsController < ApplicationController
  def index
		@flavors = Flavor.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
end

