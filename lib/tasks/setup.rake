namespace :setup do

  @private_repo = Rails.configuration.docs.private_repo
  @private_branch = Rails.configuration.docs.private_branch
  @public_repo = Rails.configuration.docs.public_repo
  @public_branch = Rails.configuration.docs.public_branch

  
  desc "Do a full setup of file and HTML imports"
  task setup_all: :environment do
    puts "Setting up public repo ..."
    Rake::Task["setup:init_public"].invoke
    puts "Setting up private repo ..."
    Rake::Task["setup:init_private"].invoke
    puts "Updating puppetdocs content ..."
    Rake::Task["setup:update_puppetdocs"].invoke
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

  desc "Update the local puppetdocs repo."
  task update_public_docs: :environment do
    system ("git submodule update --init --recursive")
    system ("git submodule foreach git pull origin master")
  end

  desc "Update the local puppetdocs repo."
  task update_public_docs: :environment do
    system ("git submodule update --init --recursive")
    system ("git submodule foreach git pull origin ")
  end

  desc "Make the tech writers admins."
  task set_admins: :environment do
    system ("rails r scripts/writers2admins.rb")
  end

  desc "Init the private repo submodule"
  task init_private: :environment do
    system("cd #{Rails.root}")
    system("git submodule add -b #{@private_branch} #{@private_repo} ./public/puppet-docs-private")
  end

  desc "Init the public repo submodule"
  task init_public: :environment do
    system("cd #{Rails.root}")
    system("git submodule add -b #{@public_branch} #{@public_repo} ./public/puppet-docs")
  end

#    config.docs.production_repo = "git@github.com:puppetlabs/puppet-docs.git"
#    config.docs.production_branch = "master"
#    config.docs.private_repo = "git@github.com:puppetlabs/puppet-docs-private.git"
#    config.docs.private_branch = "pe38-dev"

  
end
