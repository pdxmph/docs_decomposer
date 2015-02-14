pages = Page.all

# xpath for all headings
# /html/body/*[self::h1 or self::h2 or self::h3]/text()


elements = ["ol","pre","img"]

pages.each do |p|
  puts p.title
  begin
  html = Nokogiri::HTML(p.content)
  rescue
    puts "Could pull in the content for #{p.title}."
  end
  
  elements.each do |e|
  html.xpath("//section[contains(@id,'content')]//#{e}").each do |h|
    next if h['class'] == "toc" 
    hash = Digest::MD5.hexdigest(h)
    element = Element.new
    element.checksum = hash
    element.content = h
    puts element.content
    element.page_id = p.id
    element.filename = p.filename
    element.kind = e
   element.save
    
  end
  end
end


  
