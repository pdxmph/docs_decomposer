module PagesHelper

  def toggle_vote(page)
    if current_user.voted_up_on? page
      button_to 'Unflag This Page', {:controller => 'pages', :action => :downvote_page, :user_id => current_user.id, :page_id => page.id}, {:class => 'btn btn-success', :remote => true, :id => 'page_flag_button'}
    else
      button_to 'Flag This Page', {:controller => 'pages', :action => :upvote_page, :user_id => current_user.id, :page_id => page.id}, {:class => 'btn btn-success', :remote => true, :id => 'page_flag_button'}
    end
  end

  def page_voters(page)
    if page.get_upvotes.count > 0
      voters = []
      page.get_upvotes.each do |v|
        if v.voter == current_user
          voters << "you"
        else
          voters << v.voter.name
        end
      end
      return voters.to_sentence
    else
      return false
    end
  end
    
  
end
