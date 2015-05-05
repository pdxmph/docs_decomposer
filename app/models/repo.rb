class Repo < ActiveRecord::Base

  has_many :versions


  def app_directory
    "#{Rails.root}/repos/#{name}"
  end
  
  def recent_git(count=10)
    git = Git.open(self.app_directory)
    recent_log = git.log(count)
    return recent_log
  end

end
