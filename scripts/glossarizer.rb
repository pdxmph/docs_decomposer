pages = Project.find_by_name("pe").pages

common_words = ["puppet", "pe", "enterprise", "n", "y", "-"]

pages.each do |p|
  next if p.version.version_number != "3.7"
  html = Nokogiri::HTML(p.content)
  elements = ["ol","pre","img", "ul"]
  elements.each do |e|
    html.xpath("//#{e}").remove
end

 text = html.text

 ots_content = OTS.parse(text)
 
 topics  = ots_content.topics

 common_words.each { |cw| topics.delete(cw) }

 puts "#{p.title}: #{topics}"


end
