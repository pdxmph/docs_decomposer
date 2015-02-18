pages = Page.all

# xpath for all headings
# /html/body/*[self::h1 or self::h2 or self::h3]/text()


elements = ["ol","pre","img"]

pages.each do |p|
  next unless p.version == "3.0"
  html = Nokogiri::HTML(p.content)

  elements.each do |e|

    html.xpath("//div[contains(@class,'primary-content')]//#{e}").each do |h|
      next if h['class'] == "toc"
    
      hash = Digest::MD5.hexdigest(h)
      element = Element.new
      element.checksum = hash
      element.content = h
      #puts element.content
      element_head = h.xpath("preceding::*[name()='h1' or name()='h2' or name()='h3' or name()='h4' or name()='h5']")
      puts "\n"
      puts p.title
      puts p.url
      puts element_head.count
      puts element_head.last
      puts element.content
      puts "\n"
      element.page_id = p.id
      element.filename = p.filename
      element.kind = e
    #  element.save
    end
  end
end


