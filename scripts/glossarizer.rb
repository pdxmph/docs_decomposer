pages = Page.all

pages.each do |p|

 content = OTS.parse(Nokogiri::HTML(p.content).text)

 puts "#{p.title}: #{content.topics.to_sentence}"

  
end
