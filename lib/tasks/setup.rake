namespace :setup do

  @private_repo = Rails.configuration.docs.private_repo
  @private_branch = Rails.configuration.docs.private_branch
  @public_repo = Rails.configuration.docs.public_repo
  @public_branch = Rails.configuration.docs.public_branch
  @projects = ["pe","puppet","facter","hiera"]
  @repo_dirs = ["puppet-docs","puppet-docs-private"]

  desc "Import files and HTML"
  task import_content: :environment do
    Rake::Task["setup:import_public_files"].invoke
    Rake::Task["setup:import_private_files"].invoke
    Rake::Task["setup:import_html"].invoke
    Rake::Task["setup:import_elements"].invoke
    puts "Done. Ready to run."
  end

  desc "Make initial symlinks"
  task make_symlinks: :environment do 
    repos_dir = "#{Rails.root}/repos"
    public_dir = "#{Rails.root}/public"

    @repo_dirs.each do |dir|
      @projects.each do |p|
        unless File.symlink?("#{public_dir}/#{dir}/source/#{p}")
          FileUtils.ln_s("#{repos_dir}/#{dir}/source/#{p}", "#{public_dir}/#{dir}/source/")
        end
      end
    end
  end
    
  desc "Import pages from the local puppetdocs repo."
  task :import_public_files =>  ["setup:public_repo_update", :environment] do
    projects = Rails.configuration.docs.projects
    projects.each do |dir,version_list|
      version_list.each do |v|
        import_directory(dir,v,v,false)
      end
    end
  end

  desc "Import pages from the local puppet-docs-private repo."
  task :import_private_files =>  ["setup:private_repo_update", :environment] do
    directory = Rails.configuration.docs.dev_directory
    version = Rails.configuration.docs.dev_version
    version_number = Rails.configuration.docs.dev_version_number
    import_directory(directory,version,version_number,true)
  end
  
  def import_directory(directory,version_dir,version_number,priv)
    require 'find'
    content_dir = File.expand_path("#{Rails.root}/public/puppet-docs/source/#{directory}/#{version_dir}", __FILE__)
    puts "Importing #{content_dir} ..."
    project = Project.find_or_create_by(:name => directory)
      Find.find(content_dir) do |f|
        next unless f.match(/\.(markdown|md)\Z/)
        next if f.match(/.+?\/_(.+?)\.(markdown|md)/)
        project_version = project.versions.find_or_create_by(:version_number => version_number)
        begin
          src_yaml =  YAML.load_file(f)
          puts src_yaml
        rescue
          puts "Problem processing the YAML frontmatter in this file: #{f}. Skipping."
          next
        end
  
        begin
          file_name = f.match(/^.*\/source\/(.+?\.(markdown|md)$)/)[1]
        rescue
          file_name = "path_unknown"
          next
        end

        begin
          page =  project_version.pages.find_or_initialize_by(:filename => file_name)
          page.title = src_yaml['title']
          page.subtitle = src_yaml['subtitle']
          page.frontmatter = src_yaml
          page.private = priv
          page.save
        rescue Exception => e  
          puts "Problem with this file: #{f}\n#{e}"
          next
        end
      end
    puts "Done importing content for #{directory}."
  end
  
 
  desc "Import HTML for pages."
  task import_html: :environment do
    puts "Importing HTML for all tracked pages."
    system ("cd #{Rails.root}")
    system ("rails r scripts/html_importer.rb")
  end

  desc "Import elements from page HTML."
  task import_elements: :environment do
    puts "Importing ol/pre from all tracked pages."
    system ("cd #{Rails.root}")
    system ("rails r scripts/element_importer.rb")
  end

  desc "Make the tech writers admins."
  task set_admins: :environment do
    system ("rails r scripts/writers2admins.rb")
  end

  desc "Update the public docs repo"
  task :public_repo_update =>  ["setup:make_symlinks", :environment] do
    puts "Updating and copying the public docs repo."
    Dir.chdir("#{Rails.root}/repos/puppet-docs") do
      puts "Updating puppet-docs ..."
      system("git checkout master && git pull --ff && git clean --force .")
    end
  end

  desc "Update the private docs repo"
  task :private_repo_update =>  ["setup:make_symlinks", :environment] do
  puts "Updating and copying the private docs repo."
    Dir.chdir("#{Rails.root}/repos/puppet-docs-private") do
      puts "Updating puppet-docs-private ..."
      system("git checkout pe38-dev --force && git pull && git clean --force .")
    end
  end
end
