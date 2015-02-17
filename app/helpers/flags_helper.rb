module FlagsHelper


  def toggle_flag(page_id,user_id)
    if Flag.where("user_id = ? AND page_id =?", user_id, page_id).count > 0
      button_to 'Unflag This Page', {:controller => 'flags', :action => :destroy_page_flags, :user_id => @user.id, :page_id => @page.id}, {:class => 'btn btn-success', :remote => true, :id => 'page_flag_button'}
     else
    # make a button that says flag and link to flag creation action
  button_to 'Flag This Page', {:controller => 'flags', :action => :create, :user_id => @user.id, :page_id => @page.id}, {:class => 'btn btn-danger', :method => 'post', :remote => true, :id => 'page_flag_button'}
    end
  end

end
