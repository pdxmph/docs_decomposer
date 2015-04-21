class VersionsController < ApplicationController

  def show
    @version = Version.find(params[:id])
    @title = "#{@version.project.nice_name} #{@version.version_number}"
    @pages = @version.pages.order(title: :asc)
 
    render :template => "versions/show", :locals => {:pages => @pages}
  end
 
end
