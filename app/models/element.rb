class Element < ActiveRecord::Base
  validates :checksum, uniqueness: {scope: :page,
                                    message: "Just one occurrence per page"}
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
