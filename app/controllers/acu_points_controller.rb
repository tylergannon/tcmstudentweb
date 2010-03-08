class AcuPointsController < ApplicationController

  # GET /acu_points
  # GET /acu_points.xml
  def index
    @acu_points = AcuPoint.all


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @acu_points }
    end
  end

  # GET /acu_points/1
  # GET /acu_points/1.xml
  def show
    @acu_point = AcuPoint.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @acu_point }
    end
  end

  # GET /acu_points/new
  # GET /acu_points/new.xml
  def new
    @acu_point = AcuPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @acu_point }
    end
  end

  # GET /acu_points/1/edit
  def edit
    @acu_point = AcuPoint.find(params[:id])
  end

  # POST /acu_points
  # POST /acu_points.xml
  def create
    @acu_point = AcuPoint.new(params[:acu_point])

    respond_to do |format|
      if @acu_point.save
        flash[:notice] = 'Acu Point was successfully created.'
        format.html { redirect_to(@acu_point) }
        format.xml  { render :xml => @acu_point, :status => :created, :location => @acu_point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @acu_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /acu_points/1
  # PUT /acu_points/1.xml
  def update
    @acu_point = AcuPoint.find(params[:id])

    respond_to do |format|
      if @acu_point.update_attributes(params[:acu_point])
        flash[:notice] = 'Acu Point was successfully updated.'
        format.html { redirect_to(@acu_point) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acu_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /acu_points/1
  # DELETE /acu_points/1.xml
  def destroy
    @acu_point = AcuPoint.find(params[:id])
    @acu_point.destroy

    respond_to do |format|
      format.html { redirect_to(acu_points_url) }
      format.xml  { head :ok }
    end
  end
end
