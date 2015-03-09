class CommentsController < ApplicationController

  def create
    @comment = Comment.new(:content => params[:comment][:content], :user_id => params[:comment][:user_id], :page_id => params[:comment][:page_id])
    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back, :notice => "Comment saved."}
        #format.js {render :action => "pages/create_comment"}
      end
    else
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  
end
