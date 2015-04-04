namespace :setup do

  
  desc "Import files from the local puppetdocs repo."
  task import_files: :environment do
    system ("cd #{Rails.root}")
    system ("git submodule update --init --recursive")
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
    system ("git submodule foreach git pull origin master")
  end

  desc "Make the tech writers admins."
  task set_admins: :environment do
    system ("rails r scripts/writers2admins.rb")
  end
  
  
end
