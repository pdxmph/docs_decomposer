class ProjectsController < ApplicationController


  def show
    @project = Project.find(params[:id])
    @versions = @project.versions.order(version_number: :desc)
    @title = @project.nice_name
  end

  def index
    @projects = Project.all
    @title = "Projects"
  end

end
