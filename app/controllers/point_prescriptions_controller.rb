class PointPrescriptionsController < ApplicationController
  # GET /point_prescriptions
  # GET /point_prescriptions.xml
  def index
    @point_prescriptions = PointPrescription.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @point_prescriptions }
    end
  end

  # GET /point_prescriptions/1
  # GET /point_prescriptions/1.xml
  def show
    @point_prescription = PointPrescription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @point_prescription }
    end
  end

  # GET /point_prescriptions/new
  # GET /point_prescriptions/new.xml
  def new
    @point_prescription = PointPrescription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @point_prescription }
    end
  end

  # GET /point_prescriptions/1/edit
  def edit
    @point_prescription = PointPrescription.find(params[:id])
  end

  # POST /point_prescriptions
  # POST /point_prescriptions.xml
  def create
    @point_prescription = PointPrescription.new(params[:point_prescription])

    respond_to do |format|
      if @point_prescription.save
        format.html { redirect_to(@point_prescription, :notice => 'PointPrescription was successfully created.') }
        format.xml  { render :xml => @point_prescription, :status => :created, :location => @point_prescription }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @point_prescription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /point_prescriptions/1
  # PUT /point_prescriptions/1.xml
  def update
    @point_prescription = PointPrescription.find(params[:id])

    respond_to do |format|
      if @point_prescription.update_attributes(params[:point_prescription])
        format.html { redirect_to(@point_prescription, :notice => 'PointPrescription was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @point_prescription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /point_prescriptions/1
  # DELETE /point_prescriptions/1.xml
  def destroy
    @point_prescription = PointPrescription.find(params[:id])
    @point_prescription.destroy

    respond_to do |format|
      format.html { redirect_to(point_prescriptions_url) }
      format.xml  { head :ok }
    end
  end
end
