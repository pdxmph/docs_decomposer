class Project < ActiveRecord::Base

 
  has_many :versions
  has_many :pages, through: :versions

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :display_name,
      [:display_name, :id]
    ]
  end


  
  def nice_name
    case name
    when "pe"
      "Puppet Enterprise"
    when "puppet"
      "Puppet"
    when "hiera"
      "Hiera"
    when "facter"
      "Facter"
    end
  end
  
end
