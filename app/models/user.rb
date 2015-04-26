class User < ActiveRecord::Base
  acts_as_voter
  has_many :comments
  has_many :pages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  scope :admins, -> {where(:admin => true)}
  scope :supers, -> {where(:super => true)}
  
  def handle
    if self.fullname
      return self.fullname
    else
      return self.email
    end
  end

  def commented_pages
    pages = []
    self.comments.each do |c|
      pages << c.page
    end
    pages.uniq!
    return pages
  end

  def has_pages?
    if self.pages.count > 0
      return true
    else
      return false
    end
  end
  
end
