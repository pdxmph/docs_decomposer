class PagesController < ApplicationController

  def pages
    @version = params[:version]
    @pages = Page.where("version = ?", @version)
  end

  def page
    @page = Page.find(params[:id])
  end

  def highlight_page
    @page = Page.find(params[:id])
  end

end
