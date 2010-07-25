class PatternsController < ApplicationController
  respond_to :html, :js
  inherit_resources
  has_scope :from_text, :as => :text
  has_scope :tagged_with, :as => :tag

  def index
    @tags = @patterns.tag_counts_on(:tags)
    @primary_patterns = @patterns.tag_counts_on(:primary_patterns)
    @diseases = @patterns.tag_counts_on(:diseases)

    index! do |format|
      format.json {render :json=> Pattern.to_autocomplete(@patterns)}
    end
  end

  def update
    update! {(params[:commit] == "Update") ? Pattern.next_from : @pattern}
  end

#  def cards
#    @patterns = params.has_key?(:tags) ? Pattern.tagged_with(params[:tags].to_list) : Pattern.all
#    @q = []
#    @a = []

#    while @patterns.size > 0
#      newq=page
#      newa=page
#      (0..2).each do |r|
#        (0..1).each do |c|
#          if !(p = @patterns.shift).nil?
#            newq[r][c] = p
#            newa[r][1-c] = p
#          end
#        end
#      end
#      @q << newq
#      @a << newa
#    end
#    respond_with @q, @a
#  end
end

