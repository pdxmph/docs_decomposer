#!/usr/bin/env ruby
# coding: utf-8

require 'open-uri'
pages = Page.all

pages.each do |p|
  images_path = p.filename.gsub(/(^.*\/)\w{1,}\.(md|markdown)/, "/puppet-docs/source\\1")
  begin
    puts p.url

    doc = Nokogiri::HTML(open(p.url))
    doc_content = doc.xpath("//div[@id='rendered-markdown']")
    doc_content.xpath("//img").each do |i|
      if i[:src].match(/^\.\/images\//)
        i[:src] =  i[:src].gsub(/^\.\/images\//, "#{images_path}images/")
      end
    end
    p.content = doc_content.inner_html
    p.save

  rescue Exception => e  
    puts "something went wrong getting HTML for #{p.title} -- #{e}"
  end
end
  
