class Page < ActiveRecord::Base
    acts_as_votable
    has_many :elements



end

