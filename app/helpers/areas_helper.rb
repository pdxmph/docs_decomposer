module AreasHelper


  def support_indicator(area)
    case area.support_status
    when 0
      glyph = "glyphicon-question-sign"
      indicator_class = "muted"
    when 1
      glyph = "glyphicon-ok"
      indicator_class = "success"
    when 2
      glyph = "glyphicon-warning-sign"
      indicator_class = "warning"
    when 3
      glyph = "glyphicon-fire"
      indicator_class = "danger"
    end

     capture_haml do
       haml_tag :span, class: "glyphicon #{glyph} text-#{indicator_class}"
     end    
  end

  def burden_indicator(area)
    case area.burden

    when 0
      glyph = "glyphicon-question-sign"
      indicator_class = "muted"
    when 1..3
      glyph = "glyphicon-triangle-bottom"
      indicator_class = "success"
    when 2..4
      glyph = "glyphicon-ok"
      indicator_class = "success"
    when 5..6
      glyph = "glyphicon-triangle-top"
      indicator_class = "danger"
    end

     capture_haml do
       haml_tag :span, class: "glyphicon #{glyph} text-#{indicator_class}"
     end    
        
  end

  

  def area_button(area,prop)
    area = Area.find(area)
    case prop
    when "Support"
      area_prop = area.support
    when "Priority"
      area_prop = area.priority
    when "Coverage"
      area_prop = area.writer_coverage
    end
    
    case area_prop
        when 0
          word = "No"
          btn_class = "Danger"
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

    if area_prop == nil && current_user.try(:super?)
      word = "Set"
      disabled_state = nil
      btn_class = "default"
    elsif area_prop == nil && !current_user.try(:super?)
      word = "Unset"
      disabled_state = "disabled"
      btn_class = "default"
    elsif !current_user.try(:super?)
      disabled_state = "disabled"
    end

    if current_user.try(:super?)
      capture_haml do
        haml_tag :button,
                 :class => "btn btn-#{btn_class} dropdown-toggle btn-xs",
                 "data-toggle" => "dropdown",
                 :type => "button",
                 :disabled => disabled_state do
          haml_concat "#{word} #{prop}"
          if current_user.try(:super?)
            haml_tag :span, :class => "caret"
          end
        end
      end
    else
      capture_haml do
          haml_tag :span,
                   :class => "btn btn-#{btn_class}" do
            haml_concat "#{word} #{prop}"
        end
      end
    end
  end
end
