class Area < ActiveRecord::Base
  markdownize! :description

  def support_status

    if self.priority == nil || self.writer_coverage == nil || self.priority == 0 
      0
    elsif self.priority > self.writer_coverage + 1
      3
    elsif self.priority > self.writer_coverage
      2
    else
      1
    end
   
  end

  def burden
    if self.writer_coverage == nil || self.support == nil 
      0
    elsif self.writer_coverage == 0 || self.support == 0
      0
    else
      self.writer_coverage + self.support
    end
  end



  def priority_narrative
    case self.priority
    when 0
      "Undetermined"
    when 1
      "Low"
    when 2
      "Medium"
    when 3
      "High"
    end
  end

  def coverage_narrative
    case self.writer_coverage
    when 0
      "no"
    when 1
      "a little"
    when 2
      "some"
    when 3
      "substantial"
    end
  end
  
  def burden_narrative
    case self.burden
    when 0
      "an unknown"
    when 1..4
      "a relatively low"
    when 5..6
      "a relatively high"
    end
  end

  def support_narrative
    case self.support_status
    when 0
      "at Unknown Risk"
    when 1
      "at No Risk"
    when 2
      "at Risk"
    when 3
      "at High Risk"
    end
  end


end
