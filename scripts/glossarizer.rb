pages = Page.all

pages.each do |p|
  next if p.version != "3.7"
 content = OTS.parse(Nokogiri::HTML(p.content).text)

 puts "#{p.title}: #{content.topics.to_sentence}"

  
end
