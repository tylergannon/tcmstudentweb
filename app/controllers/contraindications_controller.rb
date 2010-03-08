class ContraindicationsController < ApplicationController
	load_and_authorize_resource

  def index
    @contraindications = Contraindication.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end

#  def show
#    @contraindication = Contraindication.find(params[:id])
#  end
#
#  def new
#    @contraindication = Contraindication.new
#  end
#
#  def create
#    @contraindication = Contraindication.new(params[:contraindication])
#    if @contraindication.save
#      flash[:notice] = "Successfully created contraindication."
#      redirect_to @contraindication
#    else
#      render :action => 'new'
#    end
#  end
#
#  def edit
#    @contraindication = Contraindication.find(params[:id])
#  end
#
#  def update
#    @contraindication = Contraindication.find(params[:id])
#    if @contraindication.update_attributes(params[:contraindication])
#      flash[:notice] = "Successfully updated contraindication."
#      redirect_to @contraindication
#    else
#      render :action => 'edit'
#    end
#  end
#
#  def destroy
#    @contraindication = Contraindication.find(params[:id])
#    @contraindication.destroy
#    flash[:notice] = "Successfully destroyed contraindication."
#    redirect_to contraindications_url
#  end
end
