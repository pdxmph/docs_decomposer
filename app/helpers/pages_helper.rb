module PagesHelper
  include ActsAsTaggableOn::TagsHelper

  def rank_button(page,prop)
    page = Page.find(page)
    case prop
    when "Risk"
      page_prop = page.risk
    when "Priority"
      page_prop = page.priority
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

    if page_prop == nil && current_user.try(:admin?)
      word = "Set"
      disabled_state = nil
    elsif page_prop == nil && !current_user.try(:admin?)
      word = "Unset"
      disabled_state = "disabled"
    elsif !current_user.try(:admin?)
      disabled_state = "disabled"
    end

    
    capture_haml do
      haml_tag :button,
               :class => "btn btn-#{btn_class} dropdown-toggle btn-xs",
               "data-toggle" => "dropdown",
               :type => "button",
               :disabled => disabled_state do
                 haml_concat "#{word} #{prop}"
                 if current_user.try(:admin?)
                   haml_tag :span, :class => "caret"
                 end
      end
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
end
