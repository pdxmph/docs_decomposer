class CommentsController < ApplicationController


def update
  @comment = Comment.find(params[:id])
 
  if @comment.update(:content => params[:comment][:content])
    respond_to do |format|
      format.html {redirect_to :back}
    end
    else
      respond_to do |format|
        format.html {redirect_to :back, :alert => "Didn't save your change."}
      end
     end
end

  
  def create
    @comment = Comment.new(:content => params[:comment][:content], :user_id => params[:comment][:user_id], :page_id => params[:comment][:page_id])
    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back, :notice => "Comment saved."}
      end
    else
      respond_to do |format|
        format.html {redirect_to :back, :alert => "Comment failed to save."}
      end
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    if @comment.destroy
      respond_to do |format|
       format.js
       format.html {redirect_to :back, :notice => "Comment deleted."}
      end
    end
  end
  
end
