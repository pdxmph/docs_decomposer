class Area < ActiveRecord::Base

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
end
