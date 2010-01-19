class PatternController < ApplicationController
  def index
		@patterns = Pattern.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
end

