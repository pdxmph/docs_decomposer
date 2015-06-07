class Project < ActiveRecord::Base

 
  has_many :versions, :dependent => :destroy  
  has_many :pages, through: :versions

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :display_name,
      [:display_name, :id]
    ]
  end

end
