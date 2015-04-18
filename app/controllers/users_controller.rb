class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @voted_pages = @user.get_up_voted Page
    @commented_pages = @user.commented_pages
    @pages = @user.pages 
  end

  def index
    @users = User.all
  end
  
end
