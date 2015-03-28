#!/usr/bin/env ruby


projects = {"pe" => [3.7]}

projects.each do |project,versions|

  content_dir = File.expand_path("../../public/puppet-docs/source/#{project}", __FILE__)
  
  versions.each do |version|
    dir = "#{content_dir}/#{version}"
    dir += "/reference" if project == "puppet"
   puts dir

   Dir.foreach(dir) do |file|
    next unless file.match(/.markdown|.md/) 
    file_html = file.gsub(/\.md|\.markdown/, ".html")
    src_yaml =  YAML.load_file("#{dir}/#{file}")
    puts src_yaml.inspect
    source_file = Page.new
    source_file.project = project
    source_file.version = version

    base_filename = "/#{project}/#{version}"
    base_filename += "/reference" if project == "puppet"
    source_file.filename = "#{base_filename}/#{file}"

    base_url = "https://docs.puppetlabs.com/#{project}/#{version}"
    base_url += "/reference" if project == "puppet"
    source_file.url = "#{base_url}/#{file_html}"

    source_file.title = src_yaml['title'].strip

    source_file.save    
  end
  end

  
end
