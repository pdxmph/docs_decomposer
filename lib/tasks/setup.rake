namespace :setup do

  @private_repo = Rails.configuration.docs.private_repo
  @private_branch = Rails.configuration.docs.private_branch
  @public_repo = Rails.configuration.docs.public_repo
  @public_branch = Rails.configuration.docs.public_branch

  
  desc "Import files and HTML"
  task import_content: :environment do
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

  desc "Make the tech writers admins."
  task set_admins: :environment do
    system ("rails r scripts/writers2admins.rb")
  end

  desc "Update and copy the public docs repo"
  task public_repo_update: :environment do
    Dir.chdir("#{Rails.root}/repos/puppet-docs") do
      puts "Updating puppet-docs ..."
      system("git fetch origin && git checkout --force && git clean --force .")
    end

    Dir.chdir("#{Rails.root}/public/")

    unless File.directory?("puppet-docs")
      puts "Making new public directory for puppet-docs content ..."
      system("mkdir puppet-docs")
    end

    puts "Moving content into public directory ..."
    system("cp -r #{Rails.root}/repos/puppet-docs/source ./puppet-docs")
    
  end
end
