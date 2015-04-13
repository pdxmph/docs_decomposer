require 'find'

# key = directory of a given project
# value = array of releases to pull in

content_dir = File.expand_path("#{Rails.root}/repos/puppet-docs-private/source/pe/3.7", __FILE__)
project = Project.find_or_create_by(:name => "pe")
version = project.versions.find_or_create_by(:version_number => "3.8-dev")

  Find.find(content_dir) do |f|
    next unless f.match(/\.(markdown|md)\Z/)

    begin
      src_yaml =  YAML.load_file(f)
    rescue
      puts "Problem processing the YAML frontmatter in this file: #{f}"
    end
    
      
    begin
      file_name = f.match(/^.*\/source\/(.+?\.(markdown|md)$)/)[1]
#      puts file_name
    rescue Exception => e
       puts e
       file_name = "borked file name"
       next
    end

    begin
    page = version.pages.find_or_create_by(:filename => file_name, :title => src_yaml['title'].strip, :private => true)
    rescue Exception => e  
      puts "Problem with this file: #{f}"
      puts e
    end
end
