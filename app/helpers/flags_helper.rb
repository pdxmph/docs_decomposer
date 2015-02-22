module FlagsHelper

  def toggle_flag(page_id,user_id)
    @page = Page.find(page_id)
    if @page.has_flag_from_user(user_id)
      button_to 'Unflag This Page', {:controller => 'flags', :action => :toggle_flag_from_page, :user_id => user_id, :page_id => page_id}, {:class => 'btn btn-success', :remote => true, :id => 'page_flag_button'}
     else
       button_to 'Flag This Page', {:controller => 'flags', :action => :toggle_flag_from_page, :user_id => user_id, :page_id => page_id}, {:class => 'btn btn-danger', :method => 'post', :remote => true, :id => 'page_flag_button'}
    end
  end

end
