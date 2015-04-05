class VersionsController < ApplicationController

  def show
    @version = Version.find(params[:id])
    @title = "#{@version.project.nice_name} #{@version.version_number}"
  end

  def index
    @project = Project.find(params[:project_id])

  end
  
end
