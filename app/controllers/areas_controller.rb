class AreasController < ApplicationController
  before_filter :verify_is_super, except: [:show, :index]

  
  def index
    @areas = Area.all.order(:name)
    @title = "Documentation Capacity"
    render :template => "areas/index",
           :locals => {:areas => @areas}   
  end

  def edit
    @area = Area.find(params[:id])
    @title = "Edit #{@area.name}"
  end

  def update
    @area = Area.find(params[:id])
    if @area.update_attributes(area_params)
      redirect_to areas_path
    else
      render 'edit', alert: "Bad value in your edit form. Better talk to Mike."
    end
  end

  
  def new
    @area = Area.new
  end

  def create
    @area = Area.new(:name => params[:area][:name],
                     :priority => params[:area][:priority],
                     :frequency => params[:area][:frequency],
                     :support => params[:area][:support],
                     :work => params[:area][:work])
    if @area.save
      respond_to do |format|
        format.html {redirect_to areas_path, :alert => "Area saved."}
      end
    end
  end


  def destroy
    @area = Area.find params[:id]
    if @area.destroy
      respond_to do |format|
        format.js {render :action => 'destroy_area.js.haml',
                          :locals => {:area_id => @area.id}}
      end
    end
  end

  def set_area_priority
    @priority = params[:priority]
    @area = Area.find(params[:area_id])
    @area.priority = @priority

    if @area.save
      respond_to do |format|
        format.js { render :action => 'update_priority_button.js.haml',
                           :locals => {:id => params[:area_id],
                                       :priority => @area.priority,
                                       :area => @area}}
        format.html 
      end
    end
  end

 def set_area_frequency
    @frequency = params[:frequency]
    @area = Area.find(params[:area_id])
    @area.frequency = @frequency

    if @area.save
      respond_to do |format|
        format.js { render :action => 'update_frequency_button.js.haml',
                           :locals => {:id => params[:area_id],
                                       :frequency => @area.frequency,
                                       :area => @area}}
        format.html 
      end
    end
 end

  def set_writer_coverage
    @writer_coverage = params[:writer_coverage]
    @area = Area.find(params[:area_id])
    @area.writer_coverage = @writer_coverage

    if @area.save
      respond_to do |format|
        format.js { render :action => 'update_writer_coverage_button.js.haml',
                           :locals => {:id => params[:area_id],
                                       :writer_coverage => @area.writer_coverage,
                                       :area => @area}}
        format.html 
      end
    end
  end

  def set_area_support
    @support = params[:support]
    @area = Area.find(params[:area_id])
    @area.support = @support

    if @area.save
      respond_to do |format|
        format.js { render :action => 'update_support_button.js.haml',
                           :locals => {:id => params[:area_id],
                                       :support => @area.support,
                                       :area => @area}}
        format.html 
      end
    end
  end

  private

  def area_params
    params.require(:area).permit(:area_id, :name, :priority, :work, :support, :writer_support)
  end
  
  def verify_is_admin
    (current_user.nil?) ? redirect_to(areas_path) : (redirect_to(areas_path) unless current_user.admin?)
  end

  def verify_is_super
    (current_user.nil?) ? redirect_to(areas_path) : (redirect_to(areas_path) unless current_user.super?)
  end
  
end
