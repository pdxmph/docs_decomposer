class FlagsController < ApplicationController

  def create
    @flag = Flag.new
    @flag.user_id = params[:user_id]
    @flag.page_id = params[:page_id]
    if @flag.save
      respond_to do |format|
        format.js {render inline: "location.reload();" }
#        format.html

      end
    end
  end
  
  def destroy_page_flags
    @flags = Flag.where("user_id = ? AND page_id = ?", params[:user_id], params[:page_id])
    if @flags.delete_all
      respond_to do |format|
       format.js {render inline: "location.reload();" }
      end

    end
  end
  
end
