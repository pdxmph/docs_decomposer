#!/usr/bin/env ruby

versions = ["3.0", "3.1", "3.2", "3.3", "3.7"]

content_dir = "/Users/mike/Documents/puppet-docs/source/pe"

versions.each do |v|
  dir = "#{content_dir}/#{v}"
  puts dir

  Dir.foreach(dir) do |file|
    next unless file.match(/.markdown|.md/) 
    source_file = Page.new
    source_file.version = v
    source_file.filename = "/pe/#{v}/#{file}"
    file_html = file.gsub(/\.md|\.markdown/, ".html")
    source_file.url = "https://docs.puppetlabs.com/pe/#{v}/#{file_html}"
    source_file.save    
  end


  
end
