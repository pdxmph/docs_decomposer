class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def my_flags
    @pages = current_user.get_up_voted Page
  end

  def page_params
    params.require(:page).permit(:title, :tag_list => [])
  end
  
end
