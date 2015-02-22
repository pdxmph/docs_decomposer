class Page < ActiveRecord::Base

    has_many :elements
    has_many :flags

    def has_flag_from_user(user_id)
      if Flag.where("user_id = ? AND page_id = ?", user_id, self.id).exists?
        return true
      else
        return false
      end
    end

    def delete_all_flags_from_user(user_id)
      self.flags.where("user_id = ?", user_id).each do |f|
        f.delete
        f.save
      end
    end

end

