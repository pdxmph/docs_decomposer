class Repo < ActiveRecord::Base

  validates :uri, uniqueness: :true

  has_many :projects
  has_many :pages, :through => :project
  
end
