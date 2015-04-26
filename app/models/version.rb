class Version < ActiveRecord::Base
  belongs_to :project
  has_many :pages

  scope :active, -> {where(:active => true)}

  def high_risk_pages
    self.pages.where(:risk => 3).count
  end

  def high_priority_pages
    self.pages.where(:priority => 3).count
  end
 
end
