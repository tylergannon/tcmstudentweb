class TextbooksController < ApplicationController
  respond_to :html
  respond_to :json, :only => :index

  def index
    @textbooks = Textbook.search(params[:term])
    respond_with @textbooks do |format|
      format.json {render :json=> Textbook.to_autocomplete(@textbooks)}
    end
  end

  def show
    @textbook = Textbook.find(params[:id])
    respond_with @textbook
  end

  def new
    @textbook = Textbook.new
    respond_with @textbook
  end

  def edit
    @textbook = Textbook.find(params[:id])
    respond_with @textbook
  end

  def create
    @textbook = Textbook.new(params[:textbook])
    @textbook.save
    respond_with @textbook
  end

  def update
    @textbook = Textbook.find(params[:id])
    @textbook.update_attributes(params[:textbook])
    respond_with @textbook
  end

  def destroy
    @textbook = Textbook.find(params[:id])
    @textbook.destroy
    respond_with @textbook
  end
end

