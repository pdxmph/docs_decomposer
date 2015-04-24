class PagesController < ApplicationController
  respond_to :html, :json, :xml, :js


  def tags
    @tags = Page.tag_counts
  end
  
  def tag
    @tag = params[:tag_name]
    @title = "Pages tagged with #{@tag}"
    @pages = Page.tagged_with(@tag)
  end
  
  def pages
    @version = params[:version]
    @project = params[:project]
    @pages = Page.where("version = ? AND project = ?", @version, @project)
    @title = "#{@project.nice_name} #{@version.version_number}"
  end

  
  def show
    @page = Page.friendly.find(params[:id])
    @user = current_user
    @title = @page.title
  end

  def highlight_page
    @page = Page.friendly.find(params[:id])
  end


  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params.require(:page).permit(:tag_list))
      flash[:notice] = "Successfully updated page."
      redirect_to @page
    else
      flash[:alert] = "Didn't update the page"
      redirect_to @page
    end
  end

  def add_to_tag_list
    @page = Page.find(params[:page][:page_id])
    @tags = params[:page][:tag_list]
    @page.tag_list.add(@tags, parse: true)

    if @page.save
      respond_to do |format|
       format.html { redirect_to :back }
       format.js  { render :action => 'update_tags.js.haml'}
      end
      
    else
      flash[:alert] = "Failed to change tags"
    end
  end
  
  def remove_tag
    @page = Page.find(params[:page_id])
    @tag = params[:tag]

    if @page.tag_list.remove(@tag)
      @page.save
      respond_to do |format|
        #format.html { redirect_to :back }
        format.js  { render :action => 'update_tags.js.haml'}
      end

    else
      flash[:notice] = "Didn't update the tags"
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

  def set_page_owner
    @page = Page.find(params[:page_id])
    @user = User.find(params[:user_id])

    if params[:action_id] == "disown"
      @page.user_id = nil
    else
      @page.user_id = @user.id
    end
    
    if @page.save
      respond_to do |format|
       format.js { render :action => 'set_page_owner.js.haml', :locals => {:user => @user.id}}
       format.html
      end
    end  
  end
  
  def set_page_risk
    @risk = params[:risk]
    @page = Page.find(params[:page_id])
    @page.risk = @risk

    if @page.save
      respond_to do |format|
        format.js { render :action => 'update_risk_button.js.haml', :locals => {:id => params[:page_id], :risk => @page.risk}}
        format.html
      end
    end
    
  end
  

  def set_page_priority
    @priority = params[:priority]
    @page = Page.find(params[:page_id])
    @page.priority = @priority

    if @page.save
      respond_to do |format|
        format.js { render :action => 'update_priority_button.js.haml', :locals => {:id => params[:page_id], :priority => @page.priority}}
        format.html 
      end
    end
    
  end
  
  def delete_comment
    @comment = Comment.find params[:id]
    @page = Page.find params[:page]
    if @comment.destroy
      respond_to do |format|
        format.html {redirect_to :back, :notice => "Comment deleted."}
        format.js

      end
    end
  end

  def content_reimport
    @page = Page.find params[:id]
    if @page.content_reimport
      respond_to do |format|
        format.js {render :object => @page}
      end
    end
  end
  
end
