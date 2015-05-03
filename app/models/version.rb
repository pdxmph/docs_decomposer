class Version < ActiveRecord::Base
  belongs_to :project
  has_many :pages
  belongs_to :repo
  
  def high_risk_pages
    self.pages.where(:risk => 3).count
  end

  def high_priority_pages
    self.pages.where(:priority => 3).count
  end

  scope :active, -> {where(:active => true)}
  scope :inactive, -> {where(:active => false)}

  def base_directory
    "#{self.repo.name}/source/#{self.project.name}/#{self.version_directory}"
  end

  def repos_dir
    "#{Rails.root}/repos/#{self.base_directory}"
  end

  def public_dir
    "#{Rails.root}/public/#{self.base_directory}"
  end

  def import_files
    require 'find'
    branch = self.branch
    
    Dir.chdir(self.repos_dir) do
      system("git checkout #{branch} --quiet && git pull --ff --quiet && git clean --force . --quiet")
    end
    
    Find.find(self.repos_dir) do |f|
        next unless f.match(/\.(markdown|md)\Z/)
        next if f.match(/.+?\/_(.+?)\.(markdown|md)/)
        begin
          src_yaml =  YAML.load_file(f)
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
          page =  self.pages.find_or_initialize_by(:filename => file_name)
          page.title = src_yaml['title']
          page.subtitle = src_yaml['subtitle']
          page.frontmatter = src_yaml
          page.save
        rescue Exception => e  
          puts "Problem with this file: #{f}\n#{e}"
          next
        end
      end

    
  end

end
