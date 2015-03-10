class PagesController < ApplicationController
  respond_to :html, :json, :xml, :js




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


  def update

    @page = Page.find(params[:id])
    if @page.update_attributes(params.require(:page).permit(:keyword_list))
      flash[:notice] = "Successfully updated page."
      redirect_to @page
    else
      flash[:notice] = "Didn't update the page"
      redirect_to @page
    end
  end

  def toggle_page_vote
    @page = Page.find(params[:page_id])
    @user = current_user

    if current_user.voted_up_on? @page
      @page.downvote_from @user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      @page.vote_by :voter => @user
      respond_to do |format|
       format.js 
       format.html { redirect_to :back }
      end
    end
  end


  
end
