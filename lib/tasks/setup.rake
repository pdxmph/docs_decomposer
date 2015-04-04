namespace :setup do

  desc "Do a full setup of file and HTML imports"
  task setup_all: :environment do
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
  task update_puppetdocs: :environment do
    system ("git submodule update --init --recursive")
    system ("git submodule foreach git pull origin master")
  end

  desc "Make the tech writers admins."
  task set_admins: :environment do
    system ("rails r scripts/writers2admins.rb")
  end
  
  
end
