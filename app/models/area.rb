class Area < ActiveRecord::Base

  def support_status

    if self.priority == nil || self.writer_coverage == nil
      0
    elsif self.priority > self.writer_coverage + 1
      3
    elsif self.priority > self.writer_coverage
      2
    else
      1
    end
   
  end


end
