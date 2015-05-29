class Area < ActiveRecord::Base

  def support_status

    if self.priority == nil || self.support == nil
      0
    elsif self.priority > self.support + 1
      3
    elsif self.priority > self.support
      2
    else
      1
    end
   
  end


end
