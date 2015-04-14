namespace :setup do

  @private_repo = Rails.configuration.docs.private_repo
  @private_branch = Rails.configuration.docs.private_branch
  @public_repo = Rails.configuration.docs.public_repo
  @public_branch = Rails.configuration.docs.public_branch
  
  desc "Import files and HTML"
  task import_content: :environment do
    puts "Updating public repo ..."
    Rake::Task["setup:public_repo_update"].invoke
    puts "Updating private repo ..."
    Rake::Task["setup:private_repo_update"].invoke
    puts "Importing public repo files ..."
    Rake::Task["setup:import_public_files"].invoke
    puts "Importing private repo files ..."
    Rake::Task["setup:import_private_files"].invoke
    puts "Importing HTML ..."
    Rake::Task["setup:import_html"].invoke
    puts "Importing elements ..."
    Rake::Task["setup:import_elements"].invoke
    puts "Done. Ready to run."
  end
    
  desc "Import files from the local puppetdocs repo."
  task import_public_files: :environment do
    require 'find'
    projects = Rails.configuration.docs.projects
    projects.each do |dir,version_list|
      content_dir = File.expand_path("#{Rails.root}/public/puppet-docs/source/#{dir}", __FILE__)
      project = Project.find_or_create_by(:name => dir)

      Find.find(content_dir) do |f|
        next unless f.match(/\.(markdown|md)\Z/)
        next if f.match(/.+?\/_(.+?)\.(markdown|md)/)
        begin
          version_number = f.match(/^.*\/#{dir}\/(.+?)\//)[1]
          next unless version_list.include?(version_number)
          version = project.versions.find_or_create_by(:version_number => version_number)
        rescue
          version_number = "no version"
          next
        end

        begin
          src_yaml =  YAML.load_file(f)
        rescue
          puts "Problem processing the YAML frontmatter in this file: #{f}. Skipping."
          next
        end
  
        begin
          file_name = f.match(/^.*\/source\/(.+?\.(markdown|md)$)/)[1]
        rescue
          file_name = "borked file name"
          next
        end

        begin
          version.pages.find_or_create_by(:filename => file_name, :title => src_yaml['title'].strip)
        rescue
          puts "Problem with this file: #{f}"
          next
        end
      end
    end
    puts "Done importing content."
  end

  desc "Import files from the local puppetdocs-private repo."
  task import_private_files: :environment do
    require 'find'
    project_name = 'pe'
    review_version = Rails.configuration.docs.dev_project[project_name]

    content_dir = File.expand_path("#{Rails.root}/repos/puppet-docs-private/source/#{project_name}/#{review_version}", __FILE__)
    project = Project.find_or_create_by(:name => project_name)
    version = project.versions.find_or_create_by(:version_number => review_version)

    Find.find(content_dir) do |f|
      next unless f.match(/\.(markdown|md)\Z/)
      begin
        src_yaml =  YAML.load_file(f)
      rescue
        puts "Problem processing the YAML frontmatter in this file: #{f}. Skipping."
        next
      end
          
      begin
        file_name = f.match(/^.*\/source\/(.+?\.(markdown|md)$)/)[1]
      rescue Exception => e
        puts e
        file_name = "borked file name"
        next
      end
      begin
        version.pages.find_or_create_by(:filename => file_name, :title => src_yaml['title'].strip, :private => true)
      rescue Exception => e  
        puts "Problem with this file: #{f}"
        puts e
      end
    end
    puts "Done importing review content."
  end
  
  
  desc "Import HTML for pages."
  task import_html: :environment do
    system ("cd #{Rails.root}")
    system ("rails r scripts/html_importer.rb")
  end

  desc "Import elements from page HTML."
  task import_elements: :environment do
    system ("cd #{Rails.root}")
    system ("rails r scripts/element_importer.rb")
  end

  desc "Make the tech writers admins."
  task set_admins: :environment do
    system ("rails r scripts/writers2admins.rb")
  end

  desc "Update and copy the public docs repo"
  task public_repo_update: :environment do
    Dir.chdir("#{Rails.root}/repos/puppet-docs") do
      puts "Updating puppet-docs ..."
      system("git checkout master && git pull && git clean --force .")
    end

    Dir.chdir("#{Rails.root}/public/")

    unless File.directory?("puppet-docs")
      puts "Making new public directory for puppet-docs content ..."
      system("mkdir puppet-docs")
    end

    puts "Moving content into public directory ..."
    system("cp -r #{Rails.root}/repos/puppet-docs/source ./puppet-docs")
  end

  desc "Update and copy the private docs repo"
  task private_repo_update: :environment do
    Dir.chdir("#{Rails.root}/repos/puppet-docs-private") do
      puts "Updating puppet-docs-private ..."
      system("git checkout pe38-dev --force && git pull && git clean --force .")
    end

    Dir.chdir("#{Rails.root}/public/")

    unless File.directory?("puppet-docs-private")
      puts "Making new directory for puppet-docs-private content ..."
      system("mkdir puppet-docs-private")
    end

    puts "Moving content into private directory ..."
    system("cp -r #{Rails.root}/repos/puppet-docs-private/source ./puppet-docs-private")
    puts "Done moving private content."
  end
end
