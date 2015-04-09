namespace :setup do

  @private_repo = Rails.configuration.docs.private_repo
  @private_branch = Rails.configuration.docs.private_branch
  @public_repo = Rails.configuration.docs.public_repo
  @public_branch = Rails.configuration.docs.public_branch

  
  desc "Do a full setup of file and HTML imports"
  task setup_all: :environment do
    puts "Setting up public repo ..."
    Rake::Task["setup:init_public"].invoke
    # puts "Setting up private repo ..."
    # Rake::Task["setup:init_private"].invoke
    puts "Updating repos ..."
    Rake::Task["setup:update_repos"]
    puts "Importing files ..."
    Rake::Task["setup:import_files"].invoke
    puts "Importing HTML ..."
    Rake::Task["setup:import_html"].invoke
    puts "Importing elements ..."
    Rake::Task["setup:import_elements"].invoke
    puts "Done. Ready to run."
  end
  
  
  desc "Import files from the local puppetdocs repo."
  task import_files: :environment do
    system ("cd #{Rails.root}")
    system ("rails r scripts/file_importer.rb")
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

  desc "Update the local repos."
  task update_repos: :environment do
    system ("cd #{Rails.root}/public/puppet-docs")
    system ("git co #{@public_branch} && git pull origin #{@public_branch}")
#    system ("cd #{Rails.root}/public/puppet-docs-private")
#    system ("git co #{@private_branch} && git pull origin #{@private_branch}")

  end

  desc "Make the tech writers admins."
  task set_admins: :environment do
    system ("rails r scripts/writers2admins.rb")
  end

  # desc "Init the private repo submodule"
  # task init_private: :environment do
  #   system("cd #{Rails.root}")
  #   system("git submodule add -b #{@private_branch} #{@private_repo} ./public/puppet-docs-private")
  # end

  desc "Clone, update and copy the public docs repo"
  task public_repo_setup: :environment do
    system("cd #{Rails.root}/repos")

    Dir.chdir("puppet-docs") do
      puts "Updating puppet-docs ..."
      system("git fetch origin && git checkout --force #{@public_repo} && git clean --force .")
    end

    Dir.chdir("#{Rails.root}/public/")

    unless File.directory("puppet-docs")
      puts "Making new public directory for puppet-docs content ..."
      system("mkdir puppet-docs")
    end

    puts "Moving content into public directory ..."
    system("mv #{Rails.root}/repos/puppet-docs/source ./puppet-docs")
    
  end
  

#    config.docs.production_repo = "git@github.com:puppetlabs/puppet-docs.git"
#    config.docs.production_branch = "master"
#    config.docs.private_repo = "git@github.com:puppetlabs/puppet-docs-private.git"
#    config.docs.private_branch = "pe38-dev"

  
end
