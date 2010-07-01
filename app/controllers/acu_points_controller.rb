class AcuPointsController < ApplicationController
  respond_to :html

  def index
    @acu_points = AcuPoint.all
    respond_with @acu_points
  end

  def show
    @acu_point = AcuPoint.lookup(params)
    respond_with @acu_point
  end

  def new
    @acu_point = AcuPoint.new
    respond_with @acu_point
  end

  def edit
    @acu_point = AcuPoint.lookup(params)
  end

  def create
    AcuPoint.transaction do
      respond_to do |format|
#        begin
          puts 1
          puts params[:acu_point].inspect
          @acu_point = AcuPoint.new(params[:acu_point])
          @acu_point.save!
          flash[:notice] = 'Acu Point was successfully created.'
          format.html { redirect_to(@acu_point) }
          format.xml  { render :xml => @acu_point, :status => :created, :location => @acu_point }
#        rescue
#          format.html { render :action => "new" }
#          format.xml  { render :xml => @acu_point.errors, :status => :unprocessable_entity }
#        end
      end
    end
  end

  def update
    AcuPoint.transaction do
      respond_to do |format|
#        begin
          @acu_point = AcuPoint.lookup(params)
          @acu_point.update_attributes!(params[:acu_point])
          flash[:notice] = 'Acu Point was successfully updated.'
          format.html { redirect_to(@acu_point) }
          format.xml  { head :ok }
#        rescue
#          format.html { render :action => "edit" }
#          format.xml  { render :xml => @acu_point.errors, :status => :unprocessable_entity }
#        end
      end
    end
  end


  # DELETE /acu_points/1
  # DELETE /acu_points/1.xml
  def destroy
    @acu_point = AcuPoint.lookup(params)
    @acu_point.destroy

    respond_to do |format|
      format.html { redirect_to(acu_points_url) }
      format.xml  { head :ok }
    end
  end
end
