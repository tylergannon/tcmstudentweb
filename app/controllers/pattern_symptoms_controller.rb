class PatternSymptomsController < ApplicationController
  def sort
    params[:PatternSymptoms].each_with_index do |id, index|
      PatternSymptom.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

end

