class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @pages = @user.get_up_voted Page
  end

  def index
    @users = User.all
  end
  
end
