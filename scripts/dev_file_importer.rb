require 'find'

# Setup variables
project = "pe"
dev_working_version = "3.7"
dev_version_name = "3.8-dev"


content_dir = File.expand_path("#{Rails.root}/repos/puppet-docs-private/source/pe/#{dev_working_version}", __FILE__)
project = Project.find_or_create_by(:name => project)
version = project.versions.find_or_create_by(:version_number => dev_version_name)

  Find.find(content_dir) do |f|
    next unless f.match(/\.(markdown|md)\Z/)

    begin
      src_yaml =  YAML.load_file(f)
    rescue
      puts "Problem processing the YAML frontmatter in this file: #{f}"
    end
    
      
    begin
      file_name = f.match(/^.*\/source\/(.+?\.(markdown|md)$)/)[1]
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
