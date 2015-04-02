module PagesHelper
  include ActsAsTaggableOn::TagsHelper

  def rank_button(page,prop)
    page = Page.find(page)

    case prop
    when "Risk"
      page_prop = page.risk
      glyph = "glyphicon glyphicon-warning-sign"
    when "Priority"
      page_prop = page.priority
      glyph = "glyphicon glyphicon-sort-by-attributes"
    end
    
    case page_prop
        when 1
          word = "Low"
          btn_class = "success"
        when 2
          word = "Medium"
          btn_class = "warning"
        when 3
          word = "High"
          btn_class = "danger"
        else
          word = ""
          btn_class = "primary"
    end

    if page_prop == nil
      word = "Set"
    end
    
    capture_haml do
          haml_tag :button, :class => "btn btn-#{btn_class} dropdown-toggle btn-xs", "data-toggle" => "dropdown", :type => "button" do
          haml_concat "#{word} #{prop}"
          haml_tag :span, :class => "caret"
        end
      end
     
  end
    

  def toggle_vote(page)
    if current_user.voted_up_on? page
      button_to 'Unflag This Page', {:controller => 'pages', :action => :downvote_page, :user_id => current_user.id, :page_id => page.id}, {:class => 'btn btn-success btn-xs', :remote => true, :id => 'page_flag_button'}
    else
      button_to 'Flag This Page', {:controller => 'pages', :action => :upvote_page, :user_id => current_user.id, :page_id => page.id}, {:class => 'btn btn-success btn-xs', :remote => true, :id => 'page_flag_button'}
    end
  end

  def page_voters(page)
    if page.get_upvotes.count > 0
      voters = []
      page.get_upvotes.each do |v|
        if v.voter == current_user
          voters << "You"
        else
          voters << v.voter.handle
        end
      end
      return voters.to_sentence
    else
      return false
    end
  end
  
  def inactive_rank_button(page,prop)
    page = Page.find(page)

    case prop
    when "Risk"
      page_prop = page.risk
      glyph = "glyphicon glyphicon-warning-sign"
    when "Priority"
      page_prop = page.priority
      glyph = "glyphicon glyphicon-sort-by-attributes"
    end
    
    case page_prop
        when 1
          word = "Low"
          btn_class = "success"
        when 2
          word = "Medium"
          btn_class = "warning"
        when 3
          word = "High"
          btn_class = "danger"
        else
          word = ""
          btn_class = "default"
    end

    if page_prop == nil
      word = "Unset"
    end
    
    capture_haml do
          haml_tag :button, :class => "btn btn-#{btn_class}  btn-xs", :type => "button", :disabled => "disabled" do
          haml_concat "#{prop} #{word}"
        end
      end
     
  end
  
end
