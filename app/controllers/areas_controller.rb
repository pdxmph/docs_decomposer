class AreasController < ApplicationController

  def index
    @areas = Area.all
    @title = "Documentation Capacity"
    render :template => "areas/index", :locals => {:areas => @areas}   
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
        format.js {render :action => 'destroy_area.js.haml', :locals => {:area => @area}}
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

end
