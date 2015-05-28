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
    @area = Area.new(:name => params[:area][:name], :priority => params[:area][:priority], :frequency => params[:area][:frequency], :state => params[:area][:state])
    if @area.save
      respond_to do |format|
        format.html {redirect_to areas_path, :alert => "Area saved."}
      end
    end
  end
end
