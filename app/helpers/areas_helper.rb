module AreasHelper

  def support_indicator(area)

    if area.priority == nil || area.support == nil
      glyph = "glyphicon-question-sign"
      indicator_class = "muted"
    elsif area.priority > area.support + 1
      glyph = "glyphicon-fire"
      indicator_class = "danger"
    elsif area.priority > area.support
      glyph = "glyphicon-warning-sign"
      indicator_class = "warning"
    else
      glyph = "glyphicon-ok"
      indicator_class = "success"
    end

     capture_haml do
       haml_tag :span, class: "glyphicon #{glyph} text-#{indicator_class}"
     end    
   
  end

  def support_status(area)

    if area.priority == nil || area.support == nil
      0
    elsif area.priority > area.support + 1
      3
    elsif area.priority > area.support
      2
    else
      1
    end
   
  end


  

  def area_button(area,prop)
    area = Area.find(area)
    case prop
    when "Support"
      area_prop = area.support
    when "Priority"
      area_prop = area.priority
    when "Frequency"
      area_prop = area.frequency
    end
    
    case area_prop
        when 0
          word = "No"
          btn_class = "Danger"
        when 1
          word = "Low"
          if prop == "Support"
            btn_class = "success"
          else
            btn_class ="danger"
          end
        when 2
          word = "Medium"
          btn_class = "warning"
        when 3
          word = "High"
          if prop == "Support"
            btn_class = "danger"
          else
            btn_class = "success"
          end
        else
          word = ""
          btn_class = "primary"
    end

    if area_prop == nil && current_user.try(:admin?)
      word = "Set"
      disabled_state = nil
      btn_class = "default"
    elsif area_prop == nil && !current_user.try(:admin?)
      word = "Unset"
      disabled_state = "disabled"
      btn_class = "default"
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


end
