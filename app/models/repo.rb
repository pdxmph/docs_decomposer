class Repo < ActiveRecord::Base

  has_many :versions


  def app_directory
    "#{Rails.root}/repos/#{name}"
  end
  
end
