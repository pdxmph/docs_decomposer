class User < ActiveRecord::Base
  acts_as_voter
  has_many :comments
  has_many :pages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :recoverable

  scope :admins, -> {where(:admin => true)}
    
  def commented_pages
    pages = self.comments.pluck(:page_id)
    pages.uniq!
    return Page.where(id: pages)
  end
  
  def handle
    self.fullname ? self.fullname : self.email
  end

  def has_pages?
    true ? self.pages.count > 0 : false
  end

  def has_jira_name
    true ? self.jira_name != nil : false
  end
 
end
