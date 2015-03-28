#!/usr/bin/env ruby


projects = {"pe" => [3.3,3.7], "puppet" => [3.6, 3.7], "hiera" => [1]}

projects.each do |project,versions|

  content_dir = "/Users/mike/Documents/puppet-docs/source/#{project}"

  versions.each do |version|
    dir = "#{content_dir}/#{version}"
    dir += "/reference" if project == "puppet"
   puts dir

  Dir.foreach(dir) do |file|
    next unless file.match(/.markdown|.md/) 
    src_yaml =  YAML.load_file("#{dir}/#{file}")
    puts src_yaml.inspect
    source_file = Page.new
    source_file.project = project
    source_file.version = version
    source_file.filename = "/#{project}/#{version}/#{file}"
    file_html = file.gsub(/\.md|\.markdown/, ".html")
    source_file.url = "https://docs.puppetlabs.com/#{project}/#{version}/#{file_html}"
    source_file.title = src_yaml['title'].strip
    source_file.save    
  end
  end

  
end
