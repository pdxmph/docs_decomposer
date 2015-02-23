class Page < ActiveRecord::Base
    acts_as_votable
    has_many :elements

        def previous_page
          self.class.where("id < ?", id).order("id desc").first
        end

        def next_page
          self.class.where("id > ?", id).order("id asc").first
        end

end

