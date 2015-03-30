pages = Project.find_by_name("pe").pages

common_words = ["puppet", "pe", "enterprise", "n", "y", "-"]

pages.each do |p|
  next if p.version.version_number != "3.7"
  html = Nokogiri::HTML(p.content)
  elements = ["ol","pre","img","ul","code"]
  elements.each do |e|
    html.xpath("//#{e}").remove
end

 text = html.text

 ots_content = OTS.parse(text)
 
 topics  = ots_content.topics
 keywords = ots_content.keywords
 
common_words.each { |cw| topics.delete(cw) }

# puts "#{p.title}:\n\n#{ots_content.summarize(sentences: 1)[0][:sentence]}\n\n\n"
 puts "#{p.title}:\n\n#{topics}\n\n\n"

end
