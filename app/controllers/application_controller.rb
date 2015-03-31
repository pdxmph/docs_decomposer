class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  
  def my_flags
    @pages = current_user.get_up_voted Page
  end

  def page_params
    params.require(:page).permit(:title, :tag_list => [])
  end

  def indexed_words
    @tags = Page.tag_counts_on(:indexes)
    
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :fullname
  end
  
end
