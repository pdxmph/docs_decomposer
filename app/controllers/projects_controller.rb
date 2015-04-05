class ProjectsController < ApplicationController


  def show
    @project = Project.find(params[:id])
    @title = @project.nice_name
  end

  def index
    @projects = Project.all
    @title = "Projects"
  end

end
