class Page < ActiveRecord::Base
    acts_as_votable
    has_many :comments
    has_many :elements
    accepts_nested_attributes_for :comments

    
        def previous_page
          self.class.where("id < ?", id).order("id desc").first
        end

        def next_page
          self.class.where("id > ?", id).order("id asc").first
        end

        
end

