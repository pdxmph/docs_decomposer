class User < ActiveRecord::Base
  acts_as_voter
  has_many :comments
  has_many :pages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  scope :admins, -> {where(:admin => true)}
  
  def handle
    if self.fullname
      return self.fullname
    else
      return self.email
    end
  end

  def commented_pages
    pages = self.comments.pluck(:page_id)
    pages.uniq!
    return Page.where(id: pages)
  end

  def has_pages?
    if self.pages.count > 0
      return true
    else
      return false
    end
  end
  
end
