class Version < ActiveRecord::Base
  belongs_to :project
  has_many :pages

#  validates_uniqueness_of :name, scope: :project_id

  def to_param
    version_number
  end

  
end
