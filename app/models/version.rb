class Version < ActiveRecord::Base
  belongs_to :project
  belongs_to :repo
  has_many :pages

  def high_risk_pages
    self.pages.where(:risk => 3).count
  end

  def high_priority_pages
    self.pages.where(:priority => 3).count
  end
 
end
