class User < ActiveRecord::Base
  acts_as_voter
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  def handle
    if self.name
      return self.name
    else
      return self.email
    end

  end
end
