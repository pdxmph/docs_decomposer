class CommentsController < ApplicationController

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

  
end
