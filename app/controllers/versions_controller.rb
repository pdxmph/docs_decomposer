class VersionsController < ApplicationController

  def show
    @version = Version.find(params[:id])
  end

  def index
    @project = Project.find(params[:project_id])
  end
  
end
