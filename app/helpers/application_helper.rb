# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def textile(str)
    RedCloth.new(str).to_html unless str.nil?
  end
end
