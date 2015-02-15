#!/usr/bin/env ruby

require 'open-uri'
pages = Page.all

pages.each do |p|
begin
  puts p.url

  doc = Nokogiri::HTML(open(p.url))
  doc_content = doc.xpath("//div[contains(@class,'primary-content')]")
  p.title = doc.title
  p.content = doc_content.to_html
  p.save

    rescue
    puts "something went wrong getting HTML for #{p.title}"
  end
end
  
