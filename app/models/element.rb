class Element < ActiveRecord::Base
  validates :page_id, uniqueness: {scope: :checksum}
  belongs_to :page


  def kind_name
    case kind
    when "ol"
      "Ordered List"
    when "ul"
      "Unordered List"
    when "pre"
      "Pre block"
    when "img"
      "Image"
    end
  end

  def others
   Element.where("checksum = ? AND page_id != ?",checksum, page_id)
  end
      
  
end
