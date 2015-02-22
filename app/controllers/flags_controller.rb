class FlagsController < ApplicationController
  respond_to :html, :json, :xml, :js


  def toggle_flag_from_page
    @user_id = params[:user_id]
    @page_id = params[:page_id]
    @page = Page.find(@page_id)
    
    if @page.has_flag_from_user(@user_id)
      @page.delete_all_flags_from_user(@user_id)
      respond_to do |format|
        format.js 
      end
      
    else
      @flag = Flag.new
      @flag.page_id = @page_id
      @flag.user_id = @user_id
      if @flag.save
        respond_to do |format|
          format.js
        end
      end
    end
  end
end
