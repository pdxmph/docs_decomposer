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

  def edit
    @project = Project.find(params[:id])
    @title = "Edit #{@project.display_name}"
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to projects_path
    else
      render 'edit', alert: "Bad value in your edit form. Better talk to Mike."
    end
  end

  private
  def project_params
    params.require(:project).permit(:display_name, :name, :versioned)
  end


  
end
