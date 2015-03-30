pages = Project.find_by_name("pe").pages
word_table = Hash.new(0)

progress_length = pages.count
bar = ProgressBar.new(progress_length)

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
 
 topics.each do |t|
   word_table[t] +=1
 end
 
 bar.increment!
end

Hash[word_table.sort_by{|k, v| v}.reverse].each do |k,v|
   puts "#{k}: #{v}"
end 
