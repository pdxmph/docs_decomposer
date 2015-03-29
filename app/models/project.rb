class Project < ActiveRecord::Base

  has_many :versions
  has_many :pages, through: :versions


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
