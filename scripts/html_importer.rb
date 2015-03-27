#!/usr/bin/env ruby
# coding: utf-8

require 'open-uri'
pages = Page.all

pages.each do |p|
  begin
    puts p.url

    doc = Nokogiri::HTML(open(p.url))
    doc_content = doc.xpath("//div[@id='rendered-markdown']")
    p.content = doc_content.inner_html
    p.save

  rescue Exception => e  
    puts "something went wrong getting HTML for #{p.title} -- #{e}"
  end
end
  
