class PatternSymptomsController < ApplicationController
  def sort
    params[:pattern_symptoms].each_with_index do |id, index|
      PatternSymptom.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
end

