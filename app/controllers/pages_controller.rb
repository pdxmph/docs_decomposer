class PagesController < ApplicationController

  def pages
    @version = params[:version]
    @pages = Page.where("version = ?", @version)
  end

  def page
    @page = Page.find(params[:id])
    @user = current_user
  end

  def highlight_page
    @page = Page.find(params[:id])
  end

end
