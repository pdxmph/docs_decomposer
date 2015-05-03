class VersionsController < ApplicationController
  before_filter :verify_is_admin, except: [:show, :index]
  
  def show
    @version = Version.find(params[:id])
    @title = "#{@version.project.nice_name} #{@version.version_number}"
    @pages = @version.pages.order(title: :asc)
    render :template => "versions/show", :locals => {:pages => @pages}
  end
 
  def edit
    @version = Version.find(params[:id])
    @title = "Edit #{@version.project.nice_name} #{@version.version_number}"
  end

  def update
    @version = Version.find(params[:id])
    if @version.update_attributes(version_params)
      redirect_to project_path(@version.project_id)
    else
      render 'edit', alert: "Bad value in your edit form. Better talk to Mike."
    end
  end

  private
  def version_params
    params.require(:version).permit(:project_id, :private, :branch, :source_repo, :active, :version_number, :version_directory, :repo_id)
  end

  def verify_is_admin
    (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end
end
